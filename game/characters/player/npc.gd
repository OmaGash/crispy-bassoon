extends Character

onready var player_node: Character = $"../player"
onready var ap = $NPC3/AnimationPlayer
var velocity: Vector3
var moving_right = true
onready var a = $Area
func _ready():
	_gravity = 50
	_speed =5
	ap.play("Warrior Idle-loop")
#	set_physics_process(false)
	
		


func _physics_process(delta):
	move()
	var ob = a.get_overlapping_bodies()
	print(ob)
	for i in ob:
		print(i.name)
		if i.is_in_group('group1') == true or i.is_in_group('group2') == true:
			
			ap.play("Warrior Idle-loop")
	

func move():
	velocity.y -= _gravity
	velocity.z = 0
	translation.z=0
	if translation.x < player_node.translation.x:
		velocity.x = _speed
	elif translation.x > player_node.translation.x:
		velocity.x = -_speed
		

	if is_player_moving(player_node):
		
		velocity = move_and_slide(velocity)
		ap.play("Running-loop")
	
	_on_interact_body_entered(velocity)

func stop_moving():
	velocity = Vector3.ZERO
	
	
func is_player_moving(player):
#	return player.transform.origin > Vector3(1, 6.2 , 0) or player.transform.origin < Vector3(-1 , 6.2, 0)
	return player.velocity.x > 1 or player.velocity.x < -1
	
func flip():
	self.rotation_degrees.y -= 180
	moving_right = !moving_right
	
func _on_interact_body_entered(body):
	for i in get_slide_count():
		var collision=get_slide_collision(i)
