extends KinematicBody
var velocity: Vector3
var speed:float
var state: = 0

func _ready():
	g.in_game = true
	set_physics_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		set_physics_process(true)

func _physics_process(delta):
	velocity.y -= 9.8
	velocity.x = 15
	if state == 0: $"../ui/power".value += 1
	elif state == 1:
		if $"../ui/power".value < 60 or $"../ui/power".value > 87:
			var warning = load("res://ui/warning.tscn").instance()
			add_child(warning)
			warning.warn(get_tree(), "tisod amp", "gg")
			return
		velocity.y = 1.2 * $"../ui/power".value
		state = 2
	velocity = move_and_slide(velocity)
