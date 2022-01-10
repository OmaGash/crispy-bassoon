extends Spatial

var current_level := 0 setget next_level
var current_multiplier: float = 1
var a = InputEventAction.new()

func _ready():
	g.in_game = true
	gd.stop_main_theme()
	if not g.is_mobile:
		$ui/jump.queue_free()
	g.difficulty = -1
	next_level(0)

func next_level(level: int):
	current_level = level
	match g.difficulty:
		0:
			set_multiplier(level, 1, 1.25, 1.5)
		1:
			set_multiplier(level, 1, 1.5, 2)
		2:
			set_multiplier(level, 1.5, 2, 2.5)


func set_multiplier(level: int, first: float, second: float, third: float):
	match level:
		0:
			current_multiplier = first
		1:
			current_multiplier = second
		2:
			current_multiplier = third

func _unhandled_input(event):
	if event.is_action_released("ui_accept") and $"player".state == 0 and g.difficulty != -1:
		$"player".state = 1


func _on_jump_pressed():
	var a = InputEventAction.new()
	a.action = "ui_accept"
	a.pressed = true
	Input.parse_input_event(a)


func _on_jump_button_down():
	if !a.pressed:
		a.action = "ui_accept"
		a.pressed = true
		Input.parse_input_event(a)


func _on_jump_button_up():
	if a.pressed:
		a.action = "ui_accept"
		a.pressed = false
		Input.parse_input_event(a)
