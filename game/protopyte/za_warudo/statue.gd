extends Area

export var link:NodePath

onready var link_noded: = get_node(link)

func _interact(player):
	if player.hasoffer==true:
		if link_noded==null:return
		if link_noded.has_method("interact")==true:
				link_noded.call("interact")
				player.current_state=0
				queue_free()
	
		

		
			
		
