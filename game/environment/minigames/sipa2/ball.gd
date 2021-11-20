extends KinematicBody

var velocity: Vector3

const gravity = .5
const hit_force = 20
const offset = 5

func _ready():
	randomize()

func _physics_process(delta):
	velocity.y -= gravity
	velocity.z = 0
	
	velocity = move_and_slide(velocity)


func _on_hitbox_body_entered(body):#When hit
	if body.name == "player" and not $"../player/seggs".disabled:
		velocity.y = hit_force
		velocity.x = rand_range(-offset, offset)
		get_parent().score += 1
	elif body.name == "ground":
		$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
		if $"../ui".has_node("submenu"):
			$"../ui".get_node("submenu").set_values("Game Over", "You kicked the ball " + str(get_parent().score) + " time(s).", get_parent().score * 3)
