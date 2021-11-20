extends Character
var velocity: Vector3
var speed = 25

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$"seggs".disabled = false
		$"armature kunware/anim".play("kick")
		yield($"armature kunware/anim", "animation_finished")
		$"seggs".disabled = true
		

func _physics_process(delta):
	velocity.y -= 9.8
	velocity.z = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	velocity = move_and_slide(velocity)
