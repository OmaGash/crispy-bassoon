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
var multiplier = 40

const level_constants = [[74, 100], [42, 62], [42, 52]]#the green bar's position

func _ready():
	g.in_game = true
	anim_tree["parameters/Move/blend_amount"] =  lerp(anim_tree["parameters/Move/blend_amount"], 0, BLEND_IDLE)
	set_physics_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and (g.difficulty != -1 or get_parent().current_level == 0):
		
		set_physics_process(true)
		start_progress = true

func _physics_process(delta):
	velocity.y -= 9.8
	velocity.x = 15
	
	anim_tree["parameters/Move/blend_amount"] = lerp(anim_tree["parameters/Move/blend_amount"], 1, BLEND_TO_RUN) if !$RayCast.is_colliding() else lerp(anim_tree["parameters/Move/blend_amount"], 0, .1)
	if state == 0 and start_progress: #Start running
		$"../ui/power".value += get_parent().current_multiplier
		
	elif state == 1:#Jumping state
		if $"../ui/power".value < level_constants[g.difficulty][0]:
#			anim_tree["parameters/Hit/blend_amount"] = lerp(anim_tree["parameters/Move/blend_amount"], 0, stumble)
#			anim_tree["parameters/State/active"] = true
#			return
#			yield($"luksong-baka-anim/AnimationPlayer", "animation_finished")
			anim_tree["parameters/State/active"] = false
			$"../ui/bgm".stop()
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_failed"), tr("failed_baka"), 0)
				set_physics_process(false)
			return
		velocity.y = multiplier
		state = 2
		if $"../ui/power".value > level_constants[g.difficulty][1]:
#			anim_tree["paramaters/Hit/blend_amount"] = lerp(anim_tree["parameters/Hit/blend_amount"], 1, trip)
#			anim_tree["parameters/State/active"] = true
			$"../ui/bgm".stop()
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_failed"), tr("failed_baka"), 0)
				set_physics_process(false)
			return
		if get_parent().current_level < 2:#Reset state to running after jumping
			get_parent().current_level += 1
			$"../ui/power".value = 0
			state = 0
			start_progress = false
		else:#End game
			$"../ui/bgm".stop()
			$"../ui".toggle_menu(load("res://ui/post_results.tscn"))
			anim_tree["parameters/Jump 3/active"] = true
			if $"../ui".has_node("submenu"):
				$"../ui".get_node("submenu").set_values(tr("ui_victory"), tr("victory_baka"), (g.difficulty + 1) * 5)
				
	velocity = move_and_slide(velocity)

