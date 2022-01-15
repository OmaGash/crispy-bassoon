extends Spatial

var is_rotating: bool = false
var can_rotate: bool = false

var prev_mouse_pos
var next_mouse_pos

func _physics_process(delta):
	if !can_rotate: return
	if Input.is_action_just_pressed("rotate"):
		is_rotating = true
		prev_mouse_pos = $"../preview/vport".get_mouse_position()
	if Input.is_action_just_released("rotate"):
		is_rotating = false
	
	if is_rotating:
		next_mouse_pos = $"../preview/vport".get_mouse_position()
		rotate_y((next_mouse_pos.x - prev_mouse_pos.x) * 0.1 * delta)
		rotate_x((next_mouse_pos.y - prev_mouse_pos.y) * 0.1 * delta)
		prev_mouse_pos = next_mouse_pos
