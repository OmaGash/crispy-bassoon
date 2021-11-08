extends PopupDialog
class_name Fax

func import_variables(texts: String, image_location:String = "none", video_location = "none"):
	$VBoxContainer/info.text = texts
	if image_location != "none":
		$VBoxContainer/image.texture = load(image_location) as Texture
	else:
		$VBoxContainer/image.queue_free()
	
	if video_location != "none":
		$VBoxContainer/image.texture = load(image_location) as Texture
	else:
		$VBoxContainer/video.queue_free()


func _on_close_pressed():
	$anim.play_backwards("fade")
	yield($anim, "animation_finished")
	queue_free()
