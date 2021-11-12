extends Character

#Variable for storing velocity
var velocity: = Vector3()
var gravity
#Which way is up
const UP: = Vector3(0,1,0)

#Last key pressed
var last_key := 2#0 is left, 1 is right

func _ready():
	translation.z = 0 
	gravity = 50
	_jump_force = 5

func _physics_process(delta):
	#Player will always be affected by gravity, regardless of which state they are currently in.
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, UP)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left") and (last_key == 2 or last_key == 1):
		last_key = 0
		velocity.y += _jump_force
		$Armature/AnimationPlayer.play("Climb")
	if event.is_action_pressed("move_right") and (last_key == 2 or last_key == 0):
		last_key = 1
		velocity.y += _jump_force
