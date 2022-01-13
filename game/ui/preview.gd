extends ViewportContainer

export var object: PackedScene
onready var new_object = object.instance()

func _ready():
	if object == null:
		return
	
	new_object.set_script(load("res://ui/rotate.gd"))
	add_child(new_object)
	$vport/Camera.set_script(load("res://tools/camera.gd"))
	$vport/Camera.player_node = new_object


func _on_preview_mouse_entered():
	new_object.can_rotate = true


func _on_preview_mouse_exited():
	new_object.can_rotate = false
	new_object.is_rotating = false
