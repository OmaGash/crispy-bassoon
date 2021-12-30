extends KinematicBody

var velocity: Vector3

const gravity = .5
const hit_force = 20
var offset = 5

func _ready():
	randomize()
	set_physics_process(false)
	$"../ui/difficulty".connect("difficulty_set", self, "start")

func start():
	match g.difficulty:
		0:
			offset = 5
		1:
			offset = 10
		2:
			offset = 15
	set_physics_process(true)

func _physics_process(delta):
	velocity.y -= gravity
	velocity.z = 0
	
	velocity = move_and_slide(velocity)


func _on_hitbox_body_entered(body):#When hit
	if body.name == "player" and not $"../player/seggs".disabled:
		velocity.y = hit_force
		velocity.x = rand_range(-offset, offset)
		get_parent().score += 1
	elif body.name == "ground":#Losing condition
		$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
		if $"../ui".has_node("submenu"):
			var result: String
			var win: String
			var earnings:int = get_parent().score * (g.difficulty + 1)
			if get_parent().score <= 0:
				result = "failed_sipa"
				win = "ui_failed"
				earnings = 0
			else:
				win = "ui_victory"
				result = "victory_sipa"
			$"../ui".get_node("submenu").set_values(tr(win), tr(result).format({x = get_parent().score}), earnings)
