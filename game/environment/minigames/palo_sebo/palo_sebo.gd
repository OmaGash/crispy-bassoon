extends Node

func _ready():
	$"ui/difficulty".connect("tree_exited", self, "difficulty_selected")
	
	$ui/start_button.show()
#	$ui/CenterContainer/start.connect("pressed", self, "_start_game")
	
	#$ui/start_button/start.grab_focus()

func difficulty_selected():
	match g.difficulty:
		0:
			$player.gravity = 23
			$time_limit.wait_time = 10
		1:
			$player.gravity = 27
			$time_limit.wait_time = 10
		2:
			$player.gravity = 31
			$time_limit.wait_time = 10
			

func _start_game():
	pass


