extends Node

var difficulty = 1

func _ready():
	match difficulty:
		1:
			$player.gravity = 25
		2:
			$player.gravity = 50
		3:
			$player.gravity = 75
			
	$ui/start_button.show()
#	$ui/CenterContainer/start.connect("pressed", self, "_start_game")
	$ui/start_button/start.grab_focus()

func _start_game():
	pass


