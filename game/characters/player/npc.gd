extends Character

onready var player_node: Character = $"../player"
onready var ap = $NPC3/AnimationPlayer
var velocity: Vector3


func	_ready():
	_gravity = 50
	_speed = 5
	ap.play("Warrior Idle-loop")

func _physics_process(delta):
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

func is_player_moving(player):
	return player.transform.origin > Vector3(1, 6.2 , 0) or player.transform.origin < Vector3(-1 , 6.2, 0)

func _on_interact_body_entered(body):
	for i in get_slide_count():
		var collision=get_slide_collision(i)
