extends Label


func _process(delta: float) -> void:
	text = "FPS: " + str(Engine.get_frames_per_second()) + " Vertices: " + str(Performance.get_monitor(13)) + " Draw calls: " + str(Performance.get_monitor(17))
