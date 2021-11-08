extends Node
#Global variables and functions

signal toggle_menu
signal new_pearls

var player_name = "xXDesTr00yerXx" setget _change_name
var artifact_passive = 3 #Passive unlocks
var artifact_active = 2 #active unlocks
var current_artifacts = [-1, -1] setget _artifact_swap
var in_game = false
var pearls = 50 setget update_pearls

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

func _ready():#This node will run regardless of pausing
	pause_mode = Node.PAUSE_MODE_PROCESS

func _change_name(new_name: String):
	player_name = new_name
	Dialogic.set_variable("player_name", new_name)

func _input(event):
	if event.is_action_pressed("ui_cancel") and in_game:
		pause()
		emit_signal("toggle_menu", load("res://ui/pause_menu.tscn"))
	if event.is_action_pressed("artifax") and in_game:
		pause()
		emit_signal("toggle_menu", load("res://ui/artifax/artifax.tscn"))

func pause():
	get_tree().paused = true if !get_tree().paused else false

func _artifact_swap(new_artifacts):
	current_artifacts = new_artifacts
	if has_node("/root/world"):
		if has_node("/root/world/player"):
			$"/root/world/player".update_blessings(new_artifacts)

func update_pearls(new_value):
	pearls = new_value
	emit_signal("new_pearls", pearls)
