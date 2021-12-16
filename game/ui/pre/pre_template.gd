extends Control

var next_scene: String

var data: Dictionary = {
	"langit": {
		"rules": "sample rules",
		"about": "sample fax lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum",
		"location": "res://environment/minigames/langit_lupa/langit_lupa.tscn"
	},
	"sipa": {
		"rules": "sample rules",
		"about": "sample fax",
		"location": "res://environment/minigames/sipa2/sipa.tscn"
	},
	"baka": {
		"rules": "sample rules",
		"about": "sample fax",
		"location": "res://environment/minigames/sussybaka/sussybaka.tscn"
	},
	"palo": {
		"rules": "sample rules",
		"about": "sample fax",
		"location": "res://environment/minigames/palo_sebo/palo_sebo.tscn"
	}
}

func load_data(which: String):
	$VBoxContainer/TabContainer/Rules/VBoxContainer/rule.text = data[which]["rules"]
	$VBoxContainer/TabContainer/About/VBoxContainer/fax.text = data[which]["about"]
	next_scene = data[which]["location"]


func _on_play_pressed():
	loader.load_scene(next_scene, get_tree().root.get_node("main_menu"))
