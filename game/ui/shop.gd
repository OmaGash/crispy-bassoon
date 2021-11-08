extends Control
onready var texts: = $"items/Mythical Creatures/VBoxContainer/HBoxContainer/Panel/texts"
#Where the entries are kept
var entries = {
	0: {
		"name": "Mythical",
		"description" : "occurring in or characteristic of myths or folk tales.",
		"icon": "res://icon.png",
		"owned": false,
		"price": 50,
		"fax": {
			"image": "res://icon.png",
			"video": "res://icon.mkv",
			"info": "idk you tell me"
		}
		},
	1: {
		"name": "Creatures",
		"description" : "an animal, as distinct from a human being.",
		"icon": "res://icon.png",
		"owned": false,
		"price": 69,
		"fax": {#use "none" pag n/a
			"image": "none",
			"video": "none",
			"info": "none"
			}
		}
	}
func _ready():
	$"items/Mythical Creatures/VBoxContainer/pearls".text = "Pearls: " + str(g.pearls)
	g.connect("new_pearls", self, "_update_pearls")
	for item in range(entries.size()):
		var button = Button.new()
		button.text = entries[item]["name"]
		button.icon = load(entries[item]["icon"]) as Texture
		button.connect("pressed", self, "_listing_pressed", [item])
		$"items/Mythical Creatures/VBoxContainer/HBoxContainer/listing".add_child(button)

func _listing_pressed(item_id: int):
	if texts.get_child_count() > 0:
		for child in texts.get_children():
			child.queue_free()
	var title: = Label.new()
	var description: = Label.new()
	var price: = Label.new()
	var buy_button: = Button.new()
	title.text = entries[item_id]["name"]
	description.text = entries[item_id]["description"]
	price.text = "Price: " + str(entries[item_id]["price"]) + "○"
	buy_button.connect("pressed", self, "_buy_pressed", [item_id, buy_button])
	
	if !entries[item_id]["owned"]:
		buy_button.text = "Buy"
	else:
		buy_button.disabled = true
		buy_button.text = "Owned"
	texts.add_child(title)
	texts.add_child(description)
	texts.add_child(price)
	texts.add_child(buy_button)

func _buy_pressed(item_id: int, buy_button: Button):
	var warning = load("res://ui/warning.tscn").instance()
	add_child(warning)
	if g.pearls >= entries[item_id]["price"]:
		#When item is bought, change button to view fax
		#TODO: make fax scene for spitting fax
		g.pearls -= entries[item_id]["price"]
		entries[item_id]["owned"] = true
		buy_button.disabled = true
		buy_button.text = "Owned"
		buy_button.release_focus()
		warning.warn(get_tree(), "You bought " + entries[item_id]["name"] + ".", "Purchased successfully")
	else:
		warning.warn(get_tree(), "Insufficient pearls, you need " + str(entries[item_id]["price"] - g.pearls) + " more to buy "+ entries[item_id]["name"] + ".", "Purchase unsuccessful")

func _update_pearls(current_pearls: int):
	$"items/Mythical Creatures/VBoxContainer/pearls".text = "Pearls: " + str(current_pearls)
