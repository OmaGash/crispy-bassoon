extends Node
var reset_state = false
var groundnum: int=2
onready var timer := get_node("Timer")
var wait_time: float
var lives = 3
var enemy_score = 0
var player_score = 0
var m 
var s 
onready var player = $player
onready var player_spawn = $Node/PlayerPosition
onready var npc_spawn = $Node/NPCPosition
onready var a = $npc/Area

func start():
	match g.difficulty:
		0:
			$npc.set_speed(5)
			$countdown_timer.wait_time = 15
			platform_disappear()
			$npc2.visible = false
			$npc2/Area.monitoring = false
			$npc3.visible = false
			$npc3/Area.monitoring = false
#			$npc3.Area.disabled = true
			
			
		1:
			$npc2.visible = true
			$npc3.visible = false
			$npc.set_speed(7)
			$npc2.set_speed(7)
			$countdown_timer.wait_time = 25
			$npc2._physics_process(true)
			$npc3/Area.monitoring = false
			platform_disappear()
		
		2:
			$npc2.visible = true
			$npc3.visible = true
			$npc.set_speed(9)
			$npc2.set_speed(9)
			$npc3.set_speed(9)
			$countdown_timer.wait_time = 40
			$npc2._physics_process(true)
			$npc3._physics_process(true)
			
			platform_disappear()
	set_physics_process(true)
	$countdown_timer.start()

func _ready():
	randomize()
	g.in_game = true
	gd.stop_main_theme()
	set_physics_process(false)
	$"ui/difficulty".connect("difficulty_set", self, "start")
#	get_tree().paused = true	
#	yield(get_tree().create_timer(3), "timeout")
#	get_tree().paused = false
	add_to_group("GameState")
	$countdown_timer.start()
	$GameOverScreen.get_child(0).hide()
	m = 0
	s = 20
	update_score_gui()
#	wait_time = rand_range(3.0,6.0)
#	_on_Timer_timeout()
	
#func _input(event):
	#if event.is_pressed() and !event.is_echo():
func end_game():
	var warning = load("res://ui/warning.tscn").instance()
	add_child(warning)
	warning.warn(get_tree(), "You Lose!", "Game Over")
	yield(warning, "confirmed")
	$npc/Area.monitoring
	get_tree().reload_current_scene()
#	loader.load_scene("res://environment/minigames/langit_lupa/langit_lupa.tscn", get_parent())
	pass
#
func _process(delta):
	var time_l: String = tr("ui_time_left") + "  %d"
	var time = ceil($countdown_timer.time_left)
	
	$ui/PanelContainer/countdown_label.text = time_l % [time]
	$ui/PanelContainer/countdown_label.theme = load(g.theme)
#	win_game()
	
#	if s == 0 and m >= 1:
#		s = 59
#		m -= 1
#	if m < 0:
#		s -= 1
#		m = 0
##	if m <= 0 and s < 0:
##		$Timer.stop()
#	$countdown_label.set_text("0" + str(m) + ":" + str(s))
#
#	if s < 10:
#		$countdown_label.set_text("0" + str(m) + ":" + "0" + str(s))
#	if m <= 0 and s <= 0:
#		$countdown_timer.stop()
func player_scores():
	if $countdown_timer.time_left < 1:
		$countdown_timer.stop()
		set_process(false)
		player_score += 1
		update_score_gui()
#		reset()
		
func reset():
	
	player.translate = player_spawn
	$npc.translate = npc_spawn
	
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
	if lives < 1: return
	lives -= 1
	get_tree().call_group("GUI", "update_lives", lives)
#	enemy_score += 1
#	update_score_gui()
	
#	get_tree().reload_current_scene()
	#get_tree().root.get_node("world")
	#get all mesh instances from player and change material's albedo to red
	$player/Armature/voice.stream = load("res://environment/audio/edited/grunt0.wav") as AudioStream
	$player/Armature/voice.play()
	for mesh in $player/Armature/Armature/Skeleton.get_children():
		var red: SpatialMaterial = SpatialMaterial.new()
		red.albedo_color = Color.red
		#Get every material used for each mesh
		for material in mesh.get_surface_material_count():
			var previous: Material = mesh.get_surface_material(material)
			mesh.set_surface_material(material, red)
			yield(get_tree(), "idle_frame")
			mesh.set_surface_material(material, previous)
	
	if lives < 1:
		$ui/bgm.stop()
		$ui.toggle_menu(load("res://ui/post_results.tscn"))
		if $ui.has_node("submenu"):
			$ui.get_node("submenu").set_values(tr("ui_failed"), tr("failed_langit"), 0)

	
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
	$ui/bgm.stop()
	$ui.toggle_menu(load("res://ui/post_results.tscn"))
	if $ui.has_node("submenu"):
		$ui.get_node("submenu").set_values(tr("ui_victory"), tr("victory_langit"), (max(lives, 1) * (g.difficulty + 1)) * 5)




func update_lives():
	get_tree().call_group("GUI", "update_lives", lives)

func update_score_gui():
	get_tree().call_group("GUI", "update_score", player_score , enemy_score)


func _on_countdown_timer_timeout():
	win_game()
#	s -= 1
#	player_score += 1
#	update_score_gui()
	
	
#	player_score += 1
#	update_score_gui()
#	get_tree().reload_current_scene()
#	if player_score == 3:
#		win_game()
#	
	pass # Replace with function body.
