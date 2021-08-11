extends KinematicBody

#This will define how heavy the player will be
export var gravity: = 9.807
#Player's movement speed
export var speed: = 2.0

#Variable for storing velocity
var velocity: = Vector3()
#Which way is up
var up: = Vector3(0,-1,0)

#Finite states
enum{
	IDLE,
	WALK
}

var current_state = IDLE

func _ready():
	pass 

func _physics_process(delta):
	#Player will always be affected by gravity, regardless of which state they are currently in.
	velocity.y -= gravity * delta
	#Check if current state matches any of the finite states
	#Match works similar to switch statements
	match current_state:
		IDLE:
			pass
		WALK:
			pass
	velocity = move_and_slide(velocity, up)

#All movement-related code will go here
func move(delta):
	pass
