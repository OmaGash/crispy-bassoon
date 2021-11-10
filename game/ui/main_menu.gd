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
		3:
			next_scene = "res://environment/minigames/shato/world.tscn"
		4:
			next_scene = "res://environment/Level1/level1_scene.tscn"
		5:
			next_scene = "res://pre-langit_lupa.tscn"
		6:
			next_scene = "res://protopyte/za_warudo/player_test.tscn"
		7:
			next_scene = "res://environment/minigames/palo_sebo/palo_sebo.tscn"
			
