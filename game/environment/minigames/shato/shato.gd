extends Spatial

signal hit

onready var strength: ProgressBar = $ui/strength
var started: int = -1 #-1 not started, 0 started, 1 passed 100, 2 stopped

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
		if strength.value < 100 and started == 0:
			strength.value += 1            
		elif strength.value > 0 and not started == 2:
			started = 1
			strength.value -= 1
		started = 0 if started != 1 else started
		print(started)
	elif Input.is_action_just_released("ui_accept"):
		print(strength.value)
		emit_signal("hit", strength.value)
		set_process(false)
