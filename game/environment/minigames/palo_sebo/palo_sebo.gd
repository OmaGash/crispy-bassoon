extends Node


func _ready():
	$ui/start_button.show()
#	$ui/CenterContainer/start.connect("pressed", self, "_start_game")
	$ui/start_button/start.grab_focus()
	get_tree().paused = true

func _start_game():
	pass


func _on_goal_body_entered(body: PhysicsBody):
	if body.is_in_group("player") and $time_limit.time_left > 0:
		$player.set_process_unhandled_input(false)
		$time_limit.paused = true
		$ui/win.dialog_text = "Time elapsed: " + str(floor($time_limit.wait_time - $time_limit.time_left)) + " second(s)"
		$ui/win.popup_centered()
		yield($ui/win, "confirmed")
	pass
