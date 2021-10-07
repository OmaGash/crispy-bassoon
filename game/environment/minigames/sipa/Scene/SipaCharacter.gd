extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
var speed = 4
var motion = Vector3.ZERO
var score = 0
var UP = Vector3.UP
#onready var anim : AnimationTree = $Armature/AnimationTree
const MIN_BLEND_SPEED = 0.125
const BLEND_TO_RUN = 0.2
const BLEND_IDLE = 0.1
var movement_state = 0
var facing_right = false


# Called when the node enters the scene tree for the first time.

	
func _physics_process(delta):
	
	
	move()
	#animate()

	
func move():
	move_lock_z = true
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion = Vector3(x, 0 , 0)
	move_and_slide(motion * speed, Vector3.UP)
	if motion.x < 0 and !facing_right:
		flip()
	elif motion.x > 0 and facing_right:
		flip()
	
func flip():
	self.rotation_degrees.y *= -1
	facing_right = !facing_right
	
func animate():
	
	if(motion * speed).length() > MIN_BLEND_SPEED:
		movement_state += BLEND_TO_RUN
	else:
		movement_state -= BLEND_IDLE
		
	movement_state = clamp(movement_state, 0 , 1)
	var animation = $Armature/AnimationTree
	animation["parameters/Move/blend_amount"] = movement_state
		


