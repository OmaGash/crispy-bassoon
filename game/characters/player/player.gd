extends Character

signal interact

#Variable for storing velocity
var velocity: = Vector3()
#Which way is up
const UP: = Vector3(0,1,0)
#Interaction stuff
var can_interact = false

func _ready():
	translation.z = 0 

func _physics_process(delta):
	#Player will always be affected by gravity, regardless of which state they are currently in.
	velocity.y -= _gravity * delta
	#Check if current state matches any of the finite states
	match current_state:
		_state.IDLE:
			#Idle animation goes here.
			#$anim.play("idle")
			#print("IDLE")
			_move(delta)#You can only move if you're idle/moving
		_state.MOVE:
			#print("MOVE")
			_move(delta)
		_state.DAMAGED:
			 current_hp -= 1
			#Damage indicator here
		_state.INTERACT:#Interact code goes here
			#print("INTERACT")
			velocity.x = 0
	velocity = move_and_slide(velocity, UP)

func _move(delta):
	#Interaction control
	if Input.is_action_just_pressed("interact") and can_interact:
		self.current_state = _state.INTERACT
		emit_signal("interact")
	
	#Movement controls
	if Input.is_action_just_pressed("move_up"):
		self.current_state = _state.MOVE
		#print("tomove")
		velocity.y = _jump_force
	if Input.is_action_pressed("move_left"):
		self.current_state = _state.MOVE
		velocity.x = -_speed
	elif Input.is_action_pressed("move_right"):
		self.current_state = _state.MOVE
		velocity.x = _speed
	else:
		#This makes sure na the current_state will only change kapag current_state == _state.MOVE
		self.current_state = _previous_state if current_state == _state.MOVE else current_state
		velocity.x = 0#Stop the player from moving
		
	if !is_on_floor():
		self.current_state = _state.MOVE

#The player can only interact one interactable at a time
func _on_interact_body_entered(body: Node):
	#print(body.name)
	can_interact = true
	#Connect the player to the interactable object, this way we can prevent having too many signals connected at a given time.
	connect("interact", body, "_interact")
func _on_interact_body_exited(body: Node):
	can_interact = false
	#Disconnect the player to the interactable object
	disconnect("interact", body, "_interact")
