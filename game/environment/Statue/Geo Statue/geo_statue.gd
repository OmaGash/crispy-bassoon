extends Area

onready var Player = get_parent().get_node("player")
onready var teleport_post = $Position3D.translation

func _input(event):
	
	if Input.is_action_just_pressed("interact"):
		var x = get_overlapping_areas()
		print(x)
		
		
		for i in x:
			print(i.name)
			if i.is_in_group("player"):
				Player.set_deferred('translation', teleport_post)
