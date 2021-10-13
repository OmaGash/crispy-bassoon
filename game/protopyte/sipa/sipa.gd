extends Node

const bounce_offset = Vector2(10, 15)

"""
Rules:
	1. Player kicks pebble.
	2. 1 kick = 1 prayer
	3. Pebble must not land on the ground.
Winning Condition:
	Player wins after passing a given score.
"""
func _ready() -> void:
	randomize()


func _unhandled_input(event):
	if event.is_action_pressed("arm_left"):
		$arm_l/CollisionShape.disabled = false
	elif event.is_action_pressed("arm_right"):
		$arm_r/CollisionShape.disabled = false
	elif event.is_action_pressed("knee_left"):
		$knee_l/CollisionShape.disabled = false
	elif event.is_action_pressed("knee_right"):
		$knee_r/CollisionShape.disabled = false

func _on_pebble_body_entered(body):
	if body.name == "ground":
		#Gameover
		get_tree().change_scene("res://protopyte/sipa/sipa.tscn")
	if body.is_in_group("paddle"):
		$pebble.linear_velocity = Vector3(rand_range(0, bounce_offset.x if $pebble.linear_velocity.x < 0 else -bounce_offset.x), rand_range(5, bounce_offset.y), 0)
#	print($pebble.linear_velocity)
#	if body.has_node("CollisionShape"): body.get_node("CollisionShape").disabled = true
