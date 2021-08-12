extends Character


#Variable for storing velocity
var velocity: = Vector3()
#Which way is up
var up: = Vector3(0,-1,0)


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
			_move(delta)#You can only move if you're idle/moving
		_state.MOVE:
			_move(delta)
		_state.DAMAGED:
			 current_hp -= 1
			#Damage indicator here
	velocity = move_and_slide(velocity)

func _move(delta):
	if Input.is_action_just_pressed("move_up"):
		self.current_state = _state.MOVE
		velocity.y = _jump_force
		#This makes sure na the current_state will only change kapag current_state == _state.MOVE
		self.current_state = _previous_state if current_state == _state.MOVE else current_state
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
