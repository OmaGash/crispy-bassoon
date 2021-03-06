extends Control
onready var texts: = $"items/tab_mythical/VBoxContainer/HBoxContainer/Panel/VBoxContainer/ScrollContainer/texts"
onready var preview: = $"items/tab_themes/VBoxContainer2/HBoxContainer/Panel/ScrollContainer/texts"
onready var preview_label = $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/preview_label"
onready var bg_label = $"items/tab_themes/VBoxContainer2/HBoxContainer/VBoxContainer/bg_label"
onready var bg = $"items/tab_themes/VBoxContainer2/HBoxContainer/VBoxContainer/bg"
var fax: = preload("res://ui/fax.tscn")
var preview_scn = preload("res://ui/theme.tscn")#try theme
var preview_model = preload("res://ui/preview.tscn")
var _last_theme_pressed: int
var _last_item_pressed: int
var enable_preview: bool = false#Previews can lag the game quite nicely

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
		$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/listing".add_child(button)
	#Generate Theme items---------------------------------------------------------------------------
	for item in range(g.entries.size()):
		var button = _generate_button(item)
		button.connect("pressed", self, "_theme_pressed", [item])
		if !g.entries[item]["owned"]:
			button.self_modulate = Color(.5,.5,.5,1)
		$"items/tab_themes/VBoxContainer2/HBoxContainer/VBoxContainer/listing".add_child(button)

func _generate_button(item: int) -> Button:
	var button = Button.new()
	button.name = str(item)
	button.text = g.entries[item]["name"]
	button.icon = load(g.entries[item]["icon"]) as Texture
	return button

func _listing_pressed(item_id: int):#Calls when an item on the shop is pressed
	_last_item_pressed = item_id
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
	price.text = tr("Price" )+(":")+ str(g.entries[item_id]["price"]) + "???"
	buy_button.connect("pressed", self, "_buy_pressed", [item_id, buy_button])
	
	if !g.entries[item_id]["owned"]:#Not owned yet
		buy_button.text = tr("Buy")
		preview_label.text = tr("model_locked")
		if $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child_count() > 2:#Remove existing preview
			$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child(get_child_count()-1).queue_free()
		
		#Remove toggle
		if $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer".has_node("toggle"):
			$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/toggle".queue_free()
	else:
		buy_button.text = tr("View")
		preview_label.text = tr("model_unlocked")
		if $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child_count() > 2:#Remove existing preview
			$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child(get_child_count()-1).queue_free()
		
		if enable_preview:
			var preview_scene: Control = preview_model.instance()#Add preview
			preview_scene.object = load(g.entries[item_id]["model"])
			$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".add_child(preview_scene)
		
		#Preview toggle=======================================================
		preview_toggle()
	
	texts.add_child(title)
	texts.add_child(price)
	texts.add_child(description)
	if $"items/tab_mythical/VBoxContainer/HBoxContainer/Panel/VBoxContainer".get_child_count() > 1:#Delete button if it already exists.
		$"items/tab_mythical/VBoxContainer/HBoxContainer/Panel/VBoxContainer".get_child($"items/tab_mythical/VBoxContainer/HBoxContainer/Panel/VBoxContainer".get_child_count() - 1).queue_free()
	$"items/tab_mythical/VBoxContainer/HBoxContainer/Panel/VBoxContainer".add_child(buy_button)
	
	

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
		bg_label.text = tr("bg_locked")
		bg.texture = null
	else:#Theme pressed
		var new_preview: Control = preview_scn.instance()
		var apply_button: Button = Button.new()
		apply_button.text = tr("theme3")
		new_preview.theme = load(g.entries[item_id]["theme"]) if g.entries[item_id]["theme"] != "n/a" else null
		preview.add_child(new_preview)
		preview.add_child(apply_button)
		
		bg_label.text = tr("bg_unlocked")
		bg.texture = load(g.entries[item_id]["bg"])
		
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
		$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/listing".get_node(str(item_id)).self_modulate = Color(1,1,1,1)
		$"items/tab_themes/VBoxContainer2/HBoxContainer/VBoxContainer/listing".get_node(str(item_id)).self_modulate = Color(1,1,1,1)
		buy_button.text = tr("View")
		buy_button.release_focus()
		warning.warn(get_tree(), tr("You bought")+(" ") + g.entries[item_id]["name"] + ".", tr("Purchased successfully"))
		preview_toggle()
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

func preview_toggle():
	if not $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer".has_node("toggle"):
		var preview_toggle: CheckButton = CheckButton.new()
		preview_toggle.connect("toggled", self, "_on_CheckBox_toggled")
		preview_toggle.name = "toggle"
		preview_toggle.pressed = enable_preview
		$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/preview_label".text = tr("model_unlocked") if g.entries[_last_item_pressed]["owned"] else tr("model_locked")
		$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer".add_child(preview_toggle)

func _on_CheckBox_toggled(button_pressed):#When the preview is toggled
	enable_preview = button_pressed
	if !button_pressed:
		if $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child_count() > 2:
			$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child($"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child_count()-1).queue_free()
	else:
		if $"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".get_child_count() < 3:
			var model = preview_model.instance()
			model.object = load(g.entries[_last_item_pressed]["model"])
			print(_last_item_pressed)
			$"items/tab_mythical/VBoxContainer/HBoxContainer/VBoxContainer".add_child(model)
