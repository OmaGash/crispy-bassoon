extends Control



func _on_resume_pressed():
	var a = InputEventAction.new()
	a.action = "artifax"
	a.pressed = true
	Input.parse_input_event(a)


func _on_quit_pressed():
	loader.load_scene("res://ui/main_menu.tscn", get_tree().root.get_node("world"))
	_on_resume_pressed()


func _on_reset_pressed():
#	print($"../../".filename)
	loader.load_scene($"../../".filename, $"../../")
	_on_resume_pressed()
