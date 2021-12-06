extends Node

func _ready():
	$"ui/difficulty".connect("tree_exited", self, "difficulty_selected")
	
	$ui/start_button.show()
#	$ui/CenterContainer/start.connect("pressed", self, "_start_game")
	
	#$ui/start_button/start.grab_focus()

func difficulty_selected():
	match g.difficulty:
		0:
			$player.gravity = 25
			$time_limit.wait_time = 20
		1:
			$player.gravity = 50
			$time_limit.wait_time = 10
		2:
			$player.gravity = 75
			$time_limit.wait_time = 5
			

func _start_game():
	pass


