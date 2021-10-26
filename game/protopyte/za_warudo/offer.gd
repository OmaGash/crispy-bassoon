extends Area

func _interact(player):
	player.hasoffer=true
	player.current_state=0
	queue_free()
			
	
