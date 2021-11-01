extends RigidBody

export var force2 = Vector3(0,0,1)
var chance = 1
var hold_limit = 10

func _ready():
	get_parent().connect("hit", self, "hit")

func hit(force: float):
	linear_velocity.x = force
	gravity_scale = 1

#func _unhandled_input(event): 
#	if event.is_action_pressed("ui_accept") and chance > 0: 
#		$"../Timer".wait_time = hold_limit
#		$"../Timer".start()
#		yield ($"../Timer","timeout")
#		angular_velocity[2] = 0
#		chance -= 1
#	if event.is_action_released("ui_accept") and chance > 0:
#		angular_velocity[2] = force2[2] * ($"../Timer".time_left)
#		chance -= 1
#	if event.is_action_pressed("ui_up"):
#		chance += 1
#	if event.is_action_pressed("ui_cancel"):
#		if (chance > 0):
#			get_tree().change_scene("res://environment/minigames/shato/world.tscn")
