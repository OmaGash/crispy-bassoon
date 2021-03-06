extends Control
class_name Warning, "res://addons/dialogic/Images/Event Icons/warning.svg"
#Send a warning to the user and depending on the severity of the error,
#you may force them to fix the error before proceeding with the scene.
signal confirmed
var treee
#Usage:
#var warning = load("res://ui/warning.tscn").instance()
#		add_child(warning)
#		warning.warn(get_tree(), "error message comes here")

func warn(tree: SceneTree, message: String, title: String = "Error", exit_tree:bool = false):
	$center/popup_warn.dialog_text = message
	$center/popup_warn.window_title = title
	$center.fit_child_in_rect($center/popup_warn, $center.get_rect())
	$center/popup_warn.popup()
	treee=tree
	tree.paused = true
	yield($center/popup_warn, "confirmed")
	emit_signal("confirmed")
	tree.paused = false
	if exit_tree:
		get_tree().quit()
		

func _on_popup_warn_confirmed():#Delete this node when cnofirmed
	queue_free()


func _on_Play_again_pressed():
	get_tree().reload_current_scene()


func _on_popup_warn_popup_hide():
	emit_signal("confirmed")
	treee.paused = false
	queue_free()
