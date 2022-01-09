extends CanvasLayer


func _ready():
	var os = OS.get_name()
	if os == 'Windows':
		set_process(false)
	if os == 'Android':
		set_process(true)
