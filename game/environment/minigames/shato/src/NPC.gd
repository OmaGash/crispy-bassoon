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
	pass
	

	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		set_physics_process(true)
		
func _physics_process(delta):
	var pos = stick.transform.origin
	print(pos)
	
		
	match state:
		BEFORE:
#			if translation[2] >= extreme_right[2]:
#				speed = -speed
#			if translation[2] <= extreme_left[2]:
#				speed = -speed
#			move_and_slide(Vector3(0,0, speed)) 
			if self.transform.origin == Vector3(4, 3 , 0):
				
				ap.play("Idle-loop")
			if stick.translation.z > -0.25 or stick.translation.x > -15 or stick.translation.y > 2:
				state = AFTER
		AFTER:
		
			if stick:
				direction = (stick.translation - translation).normalized()
				if not is_on_floor():
					direction.y -= gravity
				
				var x = stick.transform.origin.x
				var z = stick.transform.origin.z
				if not direction == self.transform.origin:
					face_foward(x , z)
				move_and_slide(direction * speed, Vector3(0 , 1 , 0 ))
			
func face_foward(x, z):
	rotation.y = atan2(x, z ) - PI/2


