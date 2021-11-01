extends Control
class_name Warning, "res://addons/dialogic/Images/Event Icons/warning.svg"
#Send a warning to the user and depending on the severity of the error,
#you may force them to fix the error before proceeding with the scene.

#Usage:
#var warning = load("res://ui/warning.tscn").instance()
#		add_child(warning)
#		warning.warn(get_tree(), "error message comes here")

func warn(tree: SceneTree, message: String, title: String = "Error", exit_tree:bool = false):
	$center/popup_warn.dialog_text = message
	$center/popup_warn.window_title = title
	$center.fit_child_in_rect($center/popup_warn, $center.get_rect())
	$center/popup_warn.popup()
	tree.paused = true
	yield($center/popup_warn, "confirmed")
	tree.paused = false
	if exit_tree:
		get_tree().quit()

func _on_popup_warn_confirmed():#Delete this node when cnofirmed
	queue_free()
