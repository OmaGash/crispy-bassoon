extends Control
onready var texts: = $"items/Mythical Creatures/VBoxContainer/HBoxContainer/Panel/texts"
var fax: = preload("res://ui/fax.tscn")

func _ready():
	$"items/Mythical Creatures/VBoxContainer/pearls".text = "Pearls: " + str(g.pearls)
	g.connect("new_pearls", self, "_update_pearls")
	for item in range(g.entries.size()):
		var button = Button.new()
		button.name = str(item)
		button.text = g.entries[item]["name"]
		button.icon = load(g.entries[item]["icon"]) as Texture
		button.connect("pressed", self, "_listing_pressed", [item])
		if !g.entries[item]["owned"]:
			button.self_modulate = Color(.5,.5,.5,1)
		$"items/Mythical Creatures/VBoxContainer/HBoxContainer/listing".add_child(button)

func _listing_pressed(item_id: int):
	if texts.get_child_count() > 0:
		for child in texts.get_children():
			child.queue_free()
	var title: = Label.new()
	var description: = Label.new()
	var price: = Label.new()
	var buy_button: = Button.new()
	title.text = g.entries[item_id]["name"]
	description.text = g.entries[item_id]["description"]
	price.text = "Price: " + str(g.entries[item_id]["price"]) + "○"
	buy_button.connect("pressed", self, "_buy_pressed", [item_id, buy_button])
	
	if !g.entries[item_id]["owned"]:
		buy_button.text = "Buy"
	else:
		buy_button.text = "View"
	texts.add_child(title)
	texts.add_child(description)
	texts.add_child(price)
	texts.add_child(buy_button)

func _buy_pressed(item_id: int, buy_button: Button):
	if g.entries[item_id]["owned"]:
		var fax_instance: Fax = fax.instance()
		fax_instance.import_variables(g.entries[item_id]["fax"]["info"],
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
		#TODO: make fax scene for spitting fax
		g.pearls -= g.entries[item_id]["price"]
		g.entries[item_id]["owned"] = true
		$"items/Mythical Creatures/VBoxContainer/HBoxContainer/listing".get_node(str(item_id)).self_modulate = Color(1,1,1,1)
		buy_button.text = "View"
		buy_button.release_focus()
		warning.warn(get_tree(), "You bought " + g.entries[item_id]["name"] + ".", "Purchased successfully")
		g.save()
	else:
		warning.warn(get_tree(), "Insufficient pearls, you need " + str(g.entries[item_id]["price"] - g.pearls) + " more to buy "+ g.entries[item_id]["name"] + ".", "Purchase unsuccessful")

func _update_pearls(current_pearls: int):
	$"items/Mythical Creatures/VBoxContainer/pearls".text = "Pearls: " + str(current_pearls)


func _on_close_pressed():
	#loader.load_scene("res://ui/main_menu.tscn", self)
	if get_parent().get_parent().has_node("player"):
		get_parent().get_parent().get_node("player").current_state = 0
		g.in_game = true
	get_parent().toggle_menu(load("res://ui/shop.tscn"))
