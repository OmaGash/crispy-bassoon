extends KinematicBody
var going_right = true
var going_left=true
var extreme_left=Vector3(0,0,-8)
var extreme_right=Vector3(0,0,8)
var speed=2

func _ready():
	set_physics_process(false)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		set_physics_process(true)

func _physics_process(delta):
		move_and_slide(Vector3(0,0,speed))
		if translation[2]>=extreme_right[2]:
			speed = -speed
		if translation[2]<=extreme_left[2]:
			speed = -speed


