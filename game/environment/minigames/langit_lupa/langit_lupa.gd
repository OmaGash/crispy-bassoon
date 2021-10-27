extends Node

var groundnum: int=2
onready var timer := get_node("Timer")
var wait_time: float
func _ready():
	randomize()
	wait_time=rand_range(3.0,6.0)
func _input(event):
	if event.is_pressed() and !event.is_echo():
		event=_on_Timer_timeout()
		

func _on_Timer_timeout():
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
				platform1.get_node("CollisionShape").disabled=false
			groundnum= 2
	wait_time=rand_range(3.0,6.0)
	timer.set_wait_time(wait_time)
	timer.start()
	print(wait_time)
	
			
			
		



func _on_Spatial_visibility_changed():
	pass # Replace with function body.