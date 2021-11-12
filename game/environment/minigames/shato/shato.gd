extends Spatial

signal hit

onready var strength: ProgressBar = $ui/strength
var started: int = -1 #-1 not started, 0 started, 1 passed 100, 2 stopped
var angle_y: float = 0
var angle_z: float = 0
var animated = []

func _ready():
	g.in_game = true
	print(rotation.angle_to(Vector3(0,11,0)))
	$ui/ViewportContainer/Viewport.world = get_tree().root.get_viewport().world
	$ui/ViewportContainer/Viewport/Camera.current = true
#func _unhandled_input(event):
#	while event.is_action_pressed("ui_accept") and started != 2:
#		started = 0
#		print(strength.value)
#		if strength.value < 100 and started == 0:
#			strength.value += 1
#			yield(get_tree(), "idle_frame")
#		elif strength.value > 0:
#			started = 1
#			strength.value -= 1
#			yield(get_tree(), "idle_frame")
#		started = 0 if started != 1 else started
#
func _process(delta):
	g.in_game = true
	if Input.is_action_pressed("ui_accept"):
		#animate_once($STICK.get_node("anim"), "first")
		#yield($STICK.get_node("anim"), "animation_finished")
		animate_once($STICK.get_node("anim"), "hold")
		if strength.value < 100 and started == 0:
			strength.value += 1            
		elif strength.value > 0 and not started == 2:
			started = 1
			strength.value -= 1
		started = 0 if started != 1 else started
		#print(started)
	elif Input.is_action_just_released("ui_accept"):
#		print(strength.value)
		emit_signal("hit", strength.value, angle_y, angle_z)
		$ui/ViewportContainer.visible = true
		$ui/angle_y.editable = false
		$ui/angle_z.editable = false
		set_process(false)

func animate_once(anim_node: AnimationPlayer, animation):
	if !animated.has(animation): anim_node.play(animation)
	animated.append(animation)

func _on_angle_z_value_changed(value):
	angle_z = deg2rad(value)


func _on_angle_y_value_changed(value):
	angle_y = deg2rad(value)
