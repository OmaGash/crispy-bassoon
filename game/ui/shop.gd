extends Control
onready var texts: = $"items/tab_mythical/VBoxContainer/HBoxContainer/Panel/ScrollContainer/texts"
onready var preview: = $"items/tab_themes/VBoxContainer2/HBoxContainer/Panel/ScrollContainer/texts"
var fax: = preload("res://ui/fax.tscn")
var preview_scn = preload("res://ui/preview.tscn")
var _last_theme_pressed: int

func _ready():
	theme = load(g.theme) as Theme
	$"items/tab_mythical/VBoxContainer/pearls".text = tr("pearls") + " " + str(g.pearls)
	g.connect("new_pearls", self, "_update_pearls")
	#Generate Store items---------------------------------------------------------------------------
	for item in range(g.entries.size()):
		var button = _generate_button(item)
		button.connect("pressed", self, "_listing_pressed", [item])
		if !g.entries[item]["owned"]:
			button.self_modulate = Color(.5,.5,.5,1)
		$"items/tab_mythical/VBoxContainer/HBoxContainer/listing".add_child(button)
	#Generate Theme items---------------------------------------------------------------------------
	for item in range(g.entries.size()):
		var button = _generate_button(item)
		button.connect("pressed", self, "_theme_pressed", [item])
		if !g.entries[item]["owned"]:
			button.self_modulate = Color(.5,.5,.5,1)
		$"items/tab_themes/VBoxContainer2/HBoxContainer/listing".add_child(button)

func _generate_button(item: int) -> Button:
	var button = Button.new()
	button.name = str(item)
	button.text = g.entries[item]["name"]
	button.icon = load(g.entries[item]["icon"]) as Texture
	return button

func _listing_pressed(item_id: int):
	if texts.get_child_count() > 0:#Removew everything before placing new nodes
		for child in texts.get_children():
			child.queue_free()
	var title: = Label.new()
	var description: = Label.new()
	var price: = Label.new()
	var buy_button: = Button.new()
	title.text = g.entries[item_id]["name"]
	description.text = tr(g.entries[item_id]["description"])
	description.autowrap=true
	price.text = tr("Price" )+(":")+ str(g.entries[item_id]["price"]) + "○"
	buy_button.connect("pressed", self, "_buy_pressed", [item_id, buy_button])
	
	if !g.entries[item_id]["owned"]:
		buy_button.text = tr("Buy")
	else:
		buy_button.text = tr("View")
	texts.add_child(title)
	texts.add_child(description)
	texts.add_child(price)
	texts.add_child(buy_button)

func _theme_pressed(item_id: int):
	_last_theme_pressed = item_id
	if preview.get_child_count() > 0:
		for child in preview.get_children():
			child.queue_free()
	var title: = Label.new()
	var description = Label.new()
	title.text = g.entries[item_id]["name"]
	preview.add_child(title)
	description.text = tr("theme1")+(" ") + g.entries[item_id]["name"] + ". "+ tr("theme2")
	description.autowrap=true
	preview.add_child(description)
	if not g.entries[item_id]["owned"]:
		description.text = tr("preview")
	else:
		var new_preview: Control = preview_scn.instance()
		var apply_button: Button = Button.new()
		apply_button.text = tr("theme3")
		new_preview.theme = load(g.entries[item_id]["theme"]) if g.entries[item_id]["theme"] != "n/a" else null
		preview.add_child(new_preview)
		preview.add_child(apply_button)
		if g.theme == g.entries[item_id]["theme"]:#Check if the current theme is the selected theme
			apply_button.text = tr("theme4")
			apply_button.connect("pressed", self, "_revert_pressed")
			return
		apply_button.connect("pressed", self, "_apply_pressed", [g.entries[item_id]["theme"], g.entries[item_id]["bg"]])

func _buy_pressed(item_id: int, buy_button: Button):
	if g.entries[item_id]["owned"]:
		var fax_instance: Fax = fax.instance()
		fax_instance.import_variables(tr(g.entries[item_id]["fax"]["info"]),
		g.entries[item_id]["fax"]["image"],
		g.entries[item_id]["fax"]["video"])
		add_child(fax_instance)
		fax_instance.popup_exclusive = true
		fax_instance.popup_centered()
		return
	
	var warning = load("res://ui/warning.tscn").instance()
	add_child(warning)
	if g.pearls >= g.entries[item_id]["price"]:
		#When item is bought, change button to view fax
		g.pearls -= g.entries[item_id]["price"]
		g.entries[item_id]["owned"] = true
		$"items/tab_mythical/VBoxContainer/HBoxContainer/listing".get_node(str(item_id)).self_modulate = Color(1,1,1,1)
		$"items/tab_themes/VBoxContainer2/HBoxContainer/listing".get_node(str(item_id)).self_modulate = Color(1,1,1,1)
		buy_button.text = tr("View")
		buy_button.release_focus()
		warning.warn(get_tree(), tr("You bought")+(" ") + g.entries[item_id]["name"] + ".", tr("Purchased successfully"))
		g.save()
	else:
		warning.warn(get_tree(), tr("kulang")+(" ") + str(g.entries[item_id]["price"] - g.pearls) +(" ")+tr("more to buy")+(" ")+ g.entries[item_id]["name"] + ".",tr("not_purchase"))

func _apply_pressed(theme_path, bg_path):
	theme = load(theme_path) if theme_path != "n/a" else null
	g.theme = theme_path
	_theme_pressed(_last_theme_pressed)
	g.bg = bg_path
	g.save()

func _revert_pressed():
	theme = load("res://ui/themes/default.tres")
	g.theme = "res://ui/themes/default.tres"
	g.bg = "res://ui/main menu/main-menu-background.png"
	_theme_pressed(_last_theme_pressed)
	g.save()

func _update_pearls(current_pearls: int):
	$"items/tab_mythical/VBoxContainer/pearls".text = tr("pearls") + " " + str(g.pearls)
	


func _on_close_pressed():
	#loader.load_scene("res://ui/main_menu.tscn", self)
	if get_parent().get_parent().has_node("player"):
		get_parent().get_parent().get_node("player").current_state = 0
		g.in_game = true
	get_parent().toggle_menu(load("res://ui/shop.tscn"))
