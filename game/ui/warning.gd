extends Control
class_name Warning, "res://addons/dialogic/Images/Event Icons/warning.svg"
#Send a warning to the user and depending on the severity of the error,
#you may force them to fix the error before proceeding with the scene.
func warn(message: String, title: String = "Error", exit_tree:bool = false):
	$center/popup_warn.dialog_text = message
	$center/popup_warn.window_title = title
	$center.fit_child_in_rect($center/popup_warn, $center.get_rect())
	$center/popup_warn.popup()
	get_tree().paused = true
	yield($center/popup_warn, "confirmed")
	get_tree().paused = false
	if exit_tree:
		get_tree().quit()
