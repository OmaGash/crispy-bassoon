extends RigidBody



var score = 0

func _on_Area_body_entered(body):
	if body.name == "pebble":
		apply_central_impulse(Vector3(0, 15 , 0))
	score += 1
	print("Score " + str(score))
	pass # Replace with function body.

