extends CanvasLayer


func _ready():
	set_process(false)

func _process(delta):
	var time_left: String = "Time Left: %d"
	$info/time.text = time_left % [$"../time_limit".time_left]

func _on_start_pressed():
	get_tree().paused = false
	$"../time_limit".start()
	set_process(true)
	$start_button.hide()
