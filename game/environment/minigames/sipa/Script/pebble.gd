extends RigidBody



var score = 0
const score_goal = 2

onready var gui = get_parent().get_node("CanvasLayer/HBoxContainer/Label")
onready var anim_tree = get_parent().get_node("character/Armature/AnimationTree")

	
	


func _on_kick_area_body_entered(body):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x_bounce_position = rng.randf_range(-2,  2)
	if body.name == "pebble":

		score += 1
		apply_central_impulse(Vector3(x_bounce_position, 8.3 , 0))
#		anim_tree["parameters/OneShot/active"] = true
		print("Score " + str(score))
		if score == score_goal:
			print("Congrats you win1")
	pass # Replace with function body.
