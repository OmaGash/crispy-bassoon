extends StaticBody



func _on_Area_body_entered(body):
	
	if body.name == "floor": 
		print("Game Over")
		#get_tree().change_scene("res://environment/minigames/sipa/Scene/GameOver.tscn")
	pass # Replace with function body.
