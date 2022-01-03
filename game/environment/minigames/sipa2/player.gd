extends Character
var velocity: Vector3
var speed = 10


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$"seggs".disabled = false
		$"armature kunware/anim".play("kick")
		$"anim-sipa/AnimationPlayer".play("Kick-loop")
		yield($"armature kunware/anim", "animation_finished")
		$"seggs".disabled = true
	
		

func _physics_process(delta):

	velocity.y -= 9.8
	velocity.z = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$"anim-sipa/AnimationPlayer".play("Jog Strafe Left-loop")
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$"anim-sipa/AnimationPlayer".play("Jog Strafe Right-loop")
	else:
		velocity.x = 0
		
	velocity = move_and_slide(velocity)
