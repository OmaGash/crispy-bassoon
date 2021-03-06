extends Control

class_name PreMinigame

var next_scene: String

var data: Dictionary = {
	"langit": {
		"name": tr("Langit-Lupa"),
		"rules": tr("rules_langit"),
		"about": tr("about_langit"),
		"location": "res://environment/minigames/langit_lupa/langit_lupa.tscn"
	},
	"sipa": {
		"name": tr("Sipa"),
		"rules": tr("rules_sipa"),
		"about": tr("about_sipa"),
		"location": "res://environment/minigames/sipa2/sipa.tscn"
	},
	"baka": {
		"name": tr("Luksong Baka"),
		"rules": tr("rules_baka"),
		"about": tr("about_baka"),
		"location": "res://environment/minigames/sussybaka/sussybaka.tscn"
	},
	"palo": {
		"name": tr("Palo-Sebo"),
		"rules": tr("rules_palo"),
		"about": tr("about_palo"),
		"location": "res://environment/minigames/palo_sebo/palo_sebo.tscn"
	}
}

func load_data(which: String):
	$VBoxContainer/TabContainer/tab_rules/VBoxContainer/rule.text = data[which]["rules"]
	$VBoxContainer/TabContainer/tab_about/VBoxContainer/fax.text = data[which]["about"]
	next_scene = data[which]["location"]


func _on_play_pressed():
	loader.load_scene(next_scene, get_tree().root.get_node("main_menu"))
