extends Character

onready var nav = get_parent()
var path = []
var path_node = 0
onready var player = get_parent().get_node("player")
var motion = Vector3.ZERO
var up = Vector3.UP
var moving_right = true
onready var detect = $RayCast
onready var timer = $MoveTimer
const jump_force = 5



func _ready():
	timer.set_wait_time(5)
	move_lock_z = true
	_speed = 4
	_gravity = 3
	_jump_force = 40
	timer.start()

func _physics_process(delta):
	move()
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var body = collision.collider
		if body.is_in_group("player"):
			body.hurt()
			yield()
func move():
	apply_gravity()
	var obj = detect.get_collider()
	if detect.is_colliding() and is_on_floor():
		detect.add_exception(player)
		if detect.is_colliding() and is_on_floor():
			
			motion.y = _jump_force 
			print(obj)
	if moving_right:
		motion.x = _speed
	else:
		motion.x = -_speed
	move_and_slide(motion, Vector3.UP)
	
		
func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y -= _gravity

func flip():
	self.rotation_degrees.y += -180
	moving_right = !moving_right


func _on_Timer_timeout():
	
	if detect.is_colliding() and is_on_floor():
		motion.y = _jump_force 
	if moving_right:
		motion.x = -_speed
	else:
		motion.x = _speed
	move_and_slide(motion, Vector3.UP)
	if motion.x < 0 and moving_right:
		flip()
	elif motion.x > 0 and !moving_right:
		flip()

	pass # Replace with function body.
