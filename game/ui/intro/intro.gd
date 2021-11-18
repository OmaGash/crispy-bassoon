extends Control

var intro_queue = [preload("res://ui/intro/intro0.png"),
preload("res://ui/intro/intro1.png"),
preload("res://ui/intro/intro2.jpg")]
var current = [0,0]
var scene_changing = false
#Starts with intro_queue[0],
#second is whether to play backwards[1]

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_pressed() and !event.is_echo():
		_on_fades_animation_finished("")

func _on_fades_animation_finished(anim_name):
	if current[0] == intro_queue.size():
		if !scene_changing:
			loader.load_scene("res://ui/main_menu.tscn", self)
		scene_changing = true
		return
	if current[1] == 0:#Played normally
		$fade.play_backwards("fade")
		current[0] += 1
		current[1] = 1
	elif current[1] == 1:#After playing backwards
		$credits.texture = intro_queue[current[0]]
		$fade.play("fade")
		current[1] = 0
