extends Character
var velocity: Vector3
var speed = 10
onready var anim_tree = $"anim-sipa/AnimationTree"

func ready():
	pass
	
	

func _unhandled_input(event):
	anim_tree['parameters/Strafe/blend_amount'] = 0.1
	if event.is_action_pressed("ui_accept"):
		$"seggs".disabled = false
		anim_tree['parameters/Shot/active'] = true
		$"anim-sipa/AnimationPlayer".play("Kick-loop")
		yield($"armature kunware/anim", "animation_finished")
		$"seggs".disabled = true
		
		

func _physics_process(delta):
	anim_tree['parameters/Move/blend_amount'] = 0
	velocity.y -= 9.8
	velocity.z = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		anim_tree['parameters/Strafe/blend_amount'] = 0.9
		anim_tree['parameters/Move/blend_amount'] = 1
#		$"anim-sipa/AnimationPlayer".play("Jog Strafe Left-loop")
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
		anim_tree['parameters/Strafe/blend_amount'] = 0.1
		anim_tree['parameters/Move/blend_amount'] = 1
#		$"anim-sipa/AnimationPlayer".play("Jog Strafe Right-loop")
	else:
		velocity.x = 0
		
	velocity = move_and_slide(velocity)
