extends Spatial

func _unhandled_input(event):
	if event.is_action_released("ui_accept") and $"player".state == 0:
		$"player".state = 1
