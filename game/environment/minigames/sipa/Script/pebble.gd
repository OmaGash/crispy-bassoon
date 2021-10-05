extends RigidBody



var score = 0
const score_goal = 2




	
	
func _on_HeadArea_body_entered(body):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x_bounce_position = rng.randf_range(-2,  2)
	if body.name == "pebble":
		
		score += 1
		apply_central_impulse(Vector3(x_bounce_position, 3.5 , 0))
		print("Score " + str(score))
		if score == score_goal:
			print("Congrats you win1")
		


