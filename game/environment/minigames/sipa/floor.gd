extends StaticBody




func _on_Area_body_entered(body):
	if body.name == "floor":
		get_tree().change_scene("res://GameOver.tscn")
	pass # Replace with function body.
