extends Node
#Global variables
var player_name = "xXDesTr00yerXx" setget _change_name

func _change_name(new_name: String):
	player_name = new_name
	Dialogic.set_variable("player_name", new_name)
