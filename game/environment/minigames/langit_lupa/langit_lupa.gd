extends Node
var reset_state = false
var groundnum: int=2
onready var timer := get_node("Timer")
var wait_time: float
var score = 0
onready var player = $player
onready var a = $npc/Area
func _ready():

	
	randomize()
#	wait_time = rand_range(3.0,6.0)
#	_on_Timer_timeout()
	
#func _input(event):
	#if event.is_pressed() and !event.is_echo():



func platform_disappear():
	if groundnum==2:
			for platform1 in get_tree().get_nodes_in_group("group1"):
				platform1.show()
				platform1.get_node("CollisionShape").disabled=false
			for platform1 in get_tree().get_nodes_in_group("group2"):
				platform1.hide()
				platform1.get_node("CollisionShape").disabled=true
			groundnum= 1
	elif groundnum==1:
			for platform1 in get_tree().get_nodes_in_group("group1"):
				platform1.hide()
				platform1.get_node("CollisionShape").disabled=true
			for platform1 in get_tree().get_nodes_in_group("group2"):
				platform1.show()
				platform1.get_node("CollisionShape").disabled=	false
			groundnum= 2
			
	

func _on_Timer_timeout():
	platform_disappear()
	timer.set_wait_time(6)
	timer.start()
	pass
#
#	wait_time = rand_range(3.0, 6.0)
#	timer.set_wait_time(wait_time)
#	timer.start()
#	print(wait_time)
	
			
			
func _on_Spatial_visibility_changed():
	pass # Replace with function body.


func _on_Area_body_entered(body):
	if body.name == "player":
		score += 1
		print(score)

	if body.is_in_group("group1") or body.is_in_group("group2"):
#	if body.get_name() == "platform1" or body.get_name() == "platform2" or body.get_name() == "platform3" or body.get_name() == "platform4":
		if reset_state == false:
			$npc.set_physics_process(false)
			$npc/NPC3/AnimationPlayer.play("Warrior Idle-loop")
			reset_state = true
			timer.set_wait_time(6)
			timer.start()
			_on_Timer_timeout()
		elif reset_state == true:
			timer.stop()


		print(body.get_name())
		print("ayoay")
	
		
func _on_Area_body_exited(body):

	$npc.set_physics_process(true)



