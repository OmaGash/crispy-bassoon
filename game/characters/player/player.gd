extends Character

signal interact

#Variable for storing velocity
var velocity: = Vector3()
#Which way is up
const UP: = Vector3(0,1,0)
#Interaction stuff
var can_interact = false
var jumps = 0
export var max_jumps = 1
onready var anim_tree = $"Armature/AnimationTree"
const MIN_BLEND_SPEED = 0.125
const BLEND_TO_RUN = .1
const BLEND_IDLE = 0.1
var movement_state = 0
var dir = 1 #-1 is left
var hasoffer = false setget toggle_offer

func _ready():
	translation.z = 0 
	_speed = 10
	_gravity = 50
	_jump_force = 20
	Dialogic.set_variable("name", g.player_name)
	
func _physics_process(delta):
	#Player will always be affected by gravity, regardless of which state they are currently in.
	velocity.y -= _gravity * delta
	if translation.z != 0: translation.z = 0
	#Check if current state matches any of the finite states
	match current_state:
		_state.IDLE:
			jumps = 0
			velocity.x = 0
			velocity.y = 0
			anim_tree["parameters/Fall/blend_amount"] = lerp(anim_tree["parameters/Fall/blend_amount"], 0, BLEND_TO_RUN)
			anim_tree["parameters/Move/blend_amount"] =  lerp(anim_tree["parameters/Move/blend_amount"], 0, BLEND_IDLE)
			#Idle animation goes here.
			#$anim.play("idle")
			#print("IDLE")
			_move()#You can only move if you're idle/moving
		_state.MOVE:
			#print("MOVE")
			jumps = 0 if $on_floor.is_colliding() else jumps
			_move()
			anim_tree["parameters/Fall/blend_amount"] = lerp(anim_tree["parameters/Fall/blend_amount"], 0, BLEND_TO_RUN)
			anim_tree["parameters/Move/blend_amount"] = lerp(anim_tree["parameters/Move/blend_amount"], 1, BLEND_TO_RUN)
			#Damage indicator here
		_state.INTERACT:#Interact code goes here
			#print("INTERACT")
			anim_tree["parameters/Move/blend_amount"] =  lerp(anim_tree["parameters/Move/blend_amount"], 0, BLEND_IDLE)
			velocity.x = 0
		_state.JUMP:
			_move()
			anim_tree["parameters/Shot/active"] = true
			if velocity.y < 0:
				self.current_state = _state.FALL
		_state.FALL:
			anim_tree["parameters/Fall/blend_amount"] = lerp(anim_tree["parameters/Fall/blend_amount"], 1, BLEND_IDLE)
			_move()
			print(is_on_floor(), $on_floor.is_colliding())
			if is_on_floor() and $on_floor.is_colliding():
				self.current_state = _state.IDLE
	rotation_degrees.y = lerp(rotation_degrees.y, -30, .2) if dir == -1 else lerp(rotation_degrees.y, 110, .2)
	velocity = move_and_slide(velocity, UP)

#func _unhandled_input(event: InputEvent):
#	if event is InputEventKey:
#		if event.pressed:
#			if event.is_action("interact") and !event.is_echo():
#				self.current_state = _state.INTERACT
#				emit_signal("interact")
#			if event.is_action("move_up"):
#				self.current_state = _state.MOVE
#				#print("tomove")
#				velocity.y = _jump_force
#			if event.is_action("move_left"):
#				self.current_state = _state.MOVE
#				velocity.x = -_speed
#			elif event.is_action("move_right"):
#				self.current_state = _state.MOVE
#				velocity.x = _speed
#		else:
#			#This makes sure na the current_state will only change kapag current_state == _state.MOVE
#			self.current_state = _previous_state if current_state == _state.MOVE else current_state
#			velocity.x = 0#Stop the player from moving

func update_blessings(new_blessings: Array):
	match new_blessings[0]:
		-1:
			$ilaw.hide()
			max_jumps = 1
		0:#Mermaid's Scale
			max_jumps = 1
			$ilaw.hide()
		1:#Heaven's Floret
			max_jumps = 2
			$ilaw.hide()
		2:#Wishing Star
			max_jumps = 1
			$ilaw.show()
		_:
			print(new_blessings[0])

func _move():
	#Interaction control
	if Input.is_action_just_pressed("interact") and can_interact and self.current_state == _state.IDLE:
		self.current_state = _state.INTERACT
		emit_signal("interact",self)
	
	#Movement controls
	if Input.is_action_just_pressed("move_up") and jumps < max_jumps:
		self.current_state = _state.JUMP
		#print("tomove")
		velocity.y = _jump_force
		jumps += 1
		
	
	if Input.is_action_pressed("move_left"):
		self.current_state = _state.MOVE if current_state == _state.IDLE else current_state
		velocity.x = -_speed
		dir = -1
#		rotation_degrees = Vector3(0, lerp(rotation_degrees.y, -30, .2), 0)
	elif Input.is_action_pressed("move_right"):
		self.current_state = _state.MOVE if current_state == _state.IDLE else current_state
		velocity.x = _speed
		dir = 1
#		rotation_degrees = Vector3(0, lerp(rotation_degrees.y, 110, .2), 0)
	else:
		#This makes sure na the current_state will only change kapag current_state == _state.MOVE
		self.current_state = _previous_state if current_state == _state.MOVE else current_state
		velocity.x = 0#Stop the player from moving"Armature"
	
	#Check if player is falling
	if velocity.y < 0 and !is_on_floor() and !$on_floor.is_colliding() and current_state != _state.FALL:
		print("falling at ", velocity.y)
		jumps += 1
		self.current_state = _state.FALL
#The player can only interact one interactable at a time
func _on_interact_body_entered(body: Node):
	#print(body.name)
	#Connect the player to the interactable object, this way we can prevent having too many signals connected at a given time.
	if body.is_in_group("interactable"):
		can_interact = true
		connect("interact", body, "_interact")
func _on_interact_body_exited(body: Node):
	if can_interact:
		can_interact = false
	#Disconnect the player to the interactable object
	if is_connected("interact", body, "_interact"):
		disconnect("interact", body, "_interact")

func _on_interact_area_entered(area):
	if area.is_in_group("interactable"):
		can_interact = true
		connect("interact", area, "_interact")

func _on_interact_area_exited(area):
	if can_interact:
		can_interact = false
	#Disconnect the player to the interactable object
	if is_connected("interact", area, "_interact"):
		disconnect("interact", area, "_interact")
		
func toggle_offer(uhm):
	hasoffer=uhm
	
func hurt():
	pass
