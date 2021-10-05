extends KinematicBody

var motion = Vector3()
const UP = Vector3(0,1,0)
const SPEED = 10
var score = 0

func _physics_process(delta):
	move() 
	
func move():
	var x = Input.get_action_strength("up_1") - Input.get_action_strength("down_1")
	var z = Input.get_action_strength("left_1") - Input.get_action_strength("right_1")
	
	motion = Vector3(x, 0 , z)
	
	if not motion == Vector3(0, 0 , 0):
		face_forward(x, z)
		
	move_and_slide(motion.normalized() * SPEED, UP)

func face_forward(x, z):
	rotation.y = atan2(x, z ) - PI/2


