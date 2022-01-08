extends Control

func _ready():
	theme = load(g.theme) as Theme


func _on_left_pressed():
	var a = InputEventAction.new()
	a.action = "move_left"
	a.pressed = true
	Input.parse_input_event(a)


func _on_right_pressed():
	var a = InputEventAction.new()
	a.action = "move_right"
	a.pressed = true
	Input.parse_input_event(a)
