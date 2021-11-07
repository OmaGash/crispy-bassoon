extends Character

onready var player_node: Character = $"../player"
onready var ap = $NPC3/AnimationPlayer
var velocity: Vector3
onready var a = $Area
func _ready():
	_gravity = 50
	_speed =5*3
	ap.play("Warrior Idle-loop")
#	set_physics_process(false)
	
		


func _physics_process(_delta):
	
	velocity.y -= _gravity
	velocity.z = 0
	translation.z=0
	if translation.x < player_node.translation.x - 1:
		velocity.x = _speed
		$NPC3.rotation_degrees.y = 90
	elif translation.x > player_node.translation.x + 1:
		velocity.x = -_speed
		$NPC3.rotation_degrees.y = -90
	else:
		velocity.x = 0
		ap.play("Warrior Idle-loop")
	
	if is_player_moving(player_node):
		
		velocity = move_and_slide(velocity)
		ap.play("Running-loop")
	else:
		ap.play("Warrior Idle-loop")
	
	_on_interact_body_entered(velocity)
#Replaced this bit with signals
#	var ob = a.get_overlapping_bodies()
#	for i in ob:
#		print(i.name)
#		if i.is_in_group('group1') == true or i.is_in_group('group2') == true:
#
#			ap.play("Warrior Idle-loop")

func stop_moving():
	velocity = Vector3.ZERO
	
	
func is_player_moving(player):
	return player.transform.origin > Vector3(1, 6.2 , 0) or player.transform.origin < Vector3(-1 , 6.2, 0)
#	return player.velocity.x > 1 or player.velocity.x < -1
	
func _on_interact_body_entered(_body):
	for i in get_slide_count():
		var _collision=get_slide_collision(i)


func _on_Area_body_entered(body: PhysicsBody):
	if body.is_in_group("player"):
			var warning = load("res://ui/warning.tscn").instance()
			add_child(warning)
			warning.warn(get_tree(), "naol nahabol", "awts gege")
			yield(warning, "confirmed")
			$Area.monitoring = false
			loader.load_scene("res://environment/minigames/langit_lupa/langit_lupa.tscn", get_parent())#get_tree().root.get_node("world")
	
	if body.is_in_group("group1") or body.is_in_group("group2"):
		set_physics_process(false)
		velocity.x = 0
		$NPC3/AnimationPlayer.play("Warrior Idle-loop")


func _on_Area_body_exited(body: PhysicsBody):
	if body.is_in_group("player") or body.is_in_group("group1") or body.is_in_group("group2"):
		set_physics_process(true)
