extends Control

var next_scene = "res://protopyte/za_warudo/world.tscn"

func _ready():
	g.in_game = false

func _on_start_pressed():
	loader.load_scene(next_scene, self)


func _on_quit_pressed():
	get_tree().quit()

#This is for debugging----------------------------------------------------------
func _on_ItemList_item_selected(index):
	print(index)
	match index:
		0:
			next_scene = "res://protopyte/za_warudo/world.tscn"
		1:
			next_scene = "res://environment/chapters/ch0/at_the_bay.tscn"
		2:
			next_scene = "res://protopyte/za_warudo/player_test.tscn"
