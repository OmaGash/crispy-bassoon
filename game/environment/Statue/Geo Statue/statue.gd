extends Area

onready var player = get_parent().get_node('player')

onready var teleport_pos = $Position3D.translation


func _input(event: InputEvent):
	if Input.is_action_just_pressed("interact"):
		var x = get_overlapping_areas()
		print(x)
#
#		for i in x:
#			print(i.name)
#			if i.is_in_group('player') == true:
#				print("U teleporteds")
#				player.set_deferred('translation', teleport_pos)
