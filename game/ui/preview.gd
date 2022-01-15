extends Control

export var object: PackedScene
onready var new_object = object.instance() if not object == null else null

func _ready():
	if object == null:
		return
	theme = load(g.theme)
	new_object.set_script(load("res://ui/rotate.gd"))
	add_child(new_object)
	$preview/vport/Camera.set_script(load("res://tools/camera.gd"))
	$preview/vport/Camera.player_node = new_object


func _on_preview_mouse_entered():
	new_object.can_rotate = true


func _on_preview_mouse_exited():
	new_object.can_rotate = false
	new_object.is_rotating = false


func _on_zoom_value_changed(value):
	$preview/vport/Camera.translation.z = value
