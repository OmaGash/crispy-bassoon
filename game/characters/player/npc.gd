extends Character

onready var player_node: Character = $"../player"

var velocity: Vector3


func	_ready():
	_gravity = 50
	_speed =10

func _physics_process(delta):
	velocity.y -= _gravity
	velocity.z = 0
	translation.z=0
	if translation.x < player_node.translation.x:
		velocity.x = _speed
	elif translation.x > player_node.translation.x:
		velocity.x = -_speed
	
	
	velocity=move_and_slide(velocity)
	
	_on_interact_body_entered(velocity)


func _on_interact_body_entered(body):
	for i in get_slide_count():
		var collision=get_slide_collision(i)
