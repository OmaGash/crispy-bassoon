extends KinematicBody
var velocity: Vector3
var speed:float
var state: = 0
var start_progress = false
var multiplier = 1.2
func _ready():
	g.in_game = true
	set_physics_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		set_physics_process(true)
		start_progress = true

func _physics_process(delta):
	velocity.y -= 9.8
	velocity.x = 15
	if state == 0 and start_progress: $"../ui/power".value += 1
	elif state == 1:
		if $"../ui/power".value < 60 or $"../ui/power".value > 87:
			
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_failed"), tr("failed_baka"), 0)
				set_physics_process(false)
			return
		velocity.y = multiplier * $"../ui/power".value
		state = 2
		if get_parent().current_level < 5:
			get_parent().current_level += 1
			$"../ui/power".value = 0
			state = 0
			start_progress = false
		else:
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_victory"), tr("victory_baka"), 69)
	velocity = move_and_slide(velocity)
