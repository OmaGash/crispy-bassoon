extends KinematicBody
var going_right = true
var going_left = true
var extreme_left = Vector3(0,0,-8)
var extreme_right = Vector3(0,0,8)
var speed = 6
var gravity = 50
var direction = Vector3()
#(0,0, speed)
enum {
	BEFORE,
	AFTER
}
var state = BEFORE

onready var stick = get_parent().get_node("STICK")
onready var ap = $npc1/AnimationPlayer
func _ready():
	$"../".connect("hit", self, "hit")
	set_physics_process(false)
	ap.play("Idle-loop")
func hit(_var1, _var2, _var3):
	set_physics_process(true)
		
func _physics_process(delta):
	var pos = stick.transform.origin

	ap.play("Running-loop")
	if stick:
		direction = (stick.translation - translation).normalized()
		if not is_on_floor():
			direction.y -= gravity
		
		var x = stick.transform.origin.x
		var z = stick.transform.origin.z
		if stick.translation.x < translation.x:
			$npc1.rotation_degrees.y = -90
		elif stick.translation.x > translation.x:
			$npc1.rotation_degrees.y = 90
		
		move_and_slide(direction * speed, Vector3(0 , 1 , 0 ))
			

