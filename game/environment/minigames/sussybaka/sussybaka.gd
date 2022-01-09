extends Spatial

var current_level := 0 setget next_level
var current_multiplier: float = 1

func _ready():
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
