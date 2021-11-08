extends Node
var reset_state = false
var groundnum: int=2
onready var timer := get_node("Timer")
var wait_time: float
var enemy_score = 0
var player_score = 0

onready var player = $player

onready var a = $npc/Area
func _ready():
	randomize()
	timer.start()
	$Timer2.start()
	add_to_group("GameState")

	update_score_gui()
#	wait_time = rand_range(3.0,6.0)
#	_on_Timer_timeout()
	
#func _input(event):
	#if event.is_pressed() and !event.is_echo():
func end_game():
	var warning = load("res://ui/warning.tscn").instance()
	add_child(warning)
	warning.warn(get_tree(), "naol nahabol", "awts gege")
	yield(warning, "confirmed")
	$npc/Area.monitoring
	get_tree().reload_current_scene() 
#	loader.load_scene("res://environment/minigames/langit_lupa/langit_lupa.tscn", get_parent())
	pass
	
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
	timer.set_wait_time(4)
	timer.start()
	pass
	

func _on_Timer_timeout():
	platform_disappear()
	pass
#
#	wait_time = rand_range(3.0, 6.0)
#	timer.set_wait_time(wait_time)
#	timer.start()
#	print(wait_time)
func tag():
	enemy_score += 1
	update_score_gui()
#	get_tree().reload_current_scene()
	#get_tree().root.get_node("world")
	
	if enemy_score == 3:
		end_game()
#

	
func spawn_position():
	pass
	
func _on_Area_body_entered(body):
#	
	if body.is_in_group("group1") or body.is_in_group("group2"):
#	if body.get_name() == "platform1" or body.get_name() == "platform2" or body.get_name() == "platform3" or body.get_name() == "platform4":
		if reset_state == false:
			$npc.set_physics_process(false)
			$npc/NPC3/AnimationPlayer.play("Warrior Idle-loop")
			reset_state = true
			timer.set_wait_time(3)
			timer.start()
			


func _on_Area_body_exited(_body):

	$npc.set_physics_process(true)


func win_game():
	print("You received and win this pearl ")
#	get_tree().change_scene("Vicotry.tsch")
	pass


func _on_Timer2_timeout():
	player_score += 1
	update_score_gui()
#	get_tree().reload_current_scene()
	if player_score == 3:
		win_game()
	pass # Replace with function body.
	
	
func update_score_gui():
	get_tree().call_group("GUI", "update_score", player_score , enemy_score)
