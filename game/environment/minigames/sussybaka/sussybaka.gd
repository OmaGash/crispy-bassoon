extends Spatial

var current_level = 1 setget next_level

func next_level(next):
	current_level = min(5, next)
	match current_level:
		2:
			$"player".multiplier = 2.08
		3:
			$"player".multiplier = 2.30
		4:
			$"player".multiplier = 3.9
		5:
			$"player".multiplier = 4

func _unhandled_input(event):
	if event.is_action_released("ui_accept") and $"player".state == 0:
		$"player".state = 1
		
