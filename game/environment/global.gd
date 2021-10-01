extends Node
#Global variables and functions

signal toggle_menu

var player_name = "xXDesTr00yerXx" setget _change_name
var artifact_passive = 3 #Passive unlocks
var artifact_active = 2 #active unlocks
var current_artifacts = [0, 0]

func _ready():#This node will run regardless of pausing
	pause_mode = Node.PAUSE_MODE_PROCESS

func _change_name(new_name: String):
	player_name = new_name
	Dialogic.set_variable("player_name", new_name)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause()
		emit_signal("toggle_menu", load("res://ui/artifax/artifax.tscn"))
	if event.is_action_pressed("artifax"):
		pause()
		emit_signal("toggle_menu", load("res://ui/artifax/artifax.tscn"))

func pause():
	get_tree().paused = true if !get_tree().paused else false
