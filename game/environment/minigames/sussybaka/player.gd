extends KinematicBody
var velocity: Vector3
var speed:float
var state: = 0
onready var anim_tree = $"luksong-baka-anim/AnimationTree"
const MIN_BLEND_SPEED = 0.125
const BLEND_TO_RUN = 0.2
const BLEND_IDLE = 0.1
const stumble = 0.1
const trip = 1
var start_progress = false
var multiplier = 1.2
func _ready():
	g.in_game = true
	anim_tree["parameters/Move/blend_amount"] =  lerp(anim_tree["parameters/Move/blend_amount"], 0, BLEND_IDLE)
	set_physics_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		set_physics_process(true)
		start_progress = true

func _physics_process(delta):
	velocity.y -= 9.8
	velocity.x = 15
	if state == 0 and start_progress: 
		$"../ui/power".value += 1
		anim_tree["parameters/Move/blend_amount"] = lerp(anim_tree["parameters/Move/blend_amount"], 1, BLEND_TO_RUN)
	elif state == 1:
		if $"../ui/power".value < 60:
#			anim_tree["parameters/Hit/blend_amount"] = lerp(anim_tree["parameters/Move/blend_amount"], 0, stumble)
#			anim_tree["parameters/State/active"] = true
#			return
#			yield($"luksong-baka-anim/AnimationPlayer", "animation_finished")
			anim_tree["parameters/State/active"] = false
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_failed"), tr("failed_baka"), 0)
				set_physics_process(false)
			return
		velocity.y = multiplier * $"../ui/power".value
		state = 2
		if $"../ui/power".value > 87:
#			anim_tree["paramaters/Hit/blend_amount"] = lerp(anim_tree["parameters/Hit/blend_amount"], 1, trip)
#			anim_tree["parameters/State/active"] = true
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_failed"), tr("failed_baka"), 0)
				set_physics_process(false)
			return
		if get_parent().current_level < 5:
			get_parent().current_level += 1
			$"../ui/power".value = 0
			state = 0
			start_progress = false
		else:
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			anim_tree["parameters/Jump 3/active"] = true
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_victory"), tr("victory_baka"), 69)
				
	velocity = move_and_slide(velocity)
