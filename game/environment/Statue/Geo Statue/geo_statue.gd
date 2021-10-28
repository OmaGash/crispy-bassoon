
extends "res://protopyte/za_warudo/statue.gd"
onready var playerr = get_parent().get_node('player')


func interact(player):
	teleport()

func teleport():
	
	
	var t = get_overlapping_bodies()
	print(t)
	for i in t:
		if i.is_in_group('player'):
			playerr.set_deferred('translation', $Teleport.translation)
