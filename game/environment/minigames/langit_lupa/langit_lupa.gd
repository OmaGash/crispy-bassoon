extends Node

var groundnum: int=2
onready var timer := get_node("Timer")
onready var rng=RandomNumberGenerator.new()


func _ready():
	pass

func _input(event):
	if event.is_pressed() and !event.is_echo():
		rng=timer
		event=_on_Timer_timeout()
		event=timer.set_wait_time(5)
		event=timer.start()
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
		



func _on_Spatial_visibility_changed():
	pass # Replace with function body.
