extends Control

var next_scene := "res://protopyte/za_warudo/world.tscn"
var pre_scene := preload("res://ui/pre/pre_template.tscn") as PackedScene
var shop = preload("res://ui/shop.tscn")
var mobile_selection: = preload("res://ui/gameselect.tscn")
onready var preview := $PanelContainer/categories/preview/preview_contents/actual_content/actual_actual_content

func _ready():
	g.in_game = false
	if !gd.music_player.playing: gd.next_song()
	theme = load(g.theme)
	$bg.texture = load(g.bg)

func _input(event):
	if event.is_action_pressed("delete_save"):
		g.delete_save()

func _on_start_pressed():
	if has_node("gameselect"):
		get_node("gameselect").queue_free()
	if !g.is_mobile:
		$anim.play("open_selection")
	else:
		add_child(mobile_selection.instance())
	


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
			loader.load_scene(next_scene, self)
		3:
			next_scene = "res://environment/minigames/shato/world.tscn"
		4:
			next_scene = "res://environment/Level1/level1_scene.tscn"
		5:
			next_scene = "res://pre-langit_lupa.tscn"
		6:
			next_scene = "res://pre-luksongbaka.tscn"
		7:
			next_scene = "res://environment/minigames/palo_sebo/palo_sebo.tscn"
		8:
			next_scene = "res://pre-sipa.tscn"


func _on_save_pressed():
	g.delete_save()

func load_preview(which_scene: String):
	if preview.get_child_count() > 0:
		for child in preview.get_children():
			child.queue_free()
	var pre := pre_scene.instance()
	pre.load_data(which_scene)
	preview.add_child(pre)

func _on_palo_pressed():
	load_preview("palo")

func _on_sipa_pressed():
	load_preview("sipa")


func _on_shato_pressed():
	load_preview("baka")


func _on_langit_pressed():
	load_preview("langit")


func _on_close_pressed():
	$anim.play_backwards("open_selection")
	yield($anim, "animation_finished")
	$PanelContainer.visible = false


func _on_shop_pressed():
	$ui.toggle_menu(load("res://ui/shop.tscn"))
	yield(get_tree(), "idle_frame")
	yield($ui.get_node("submenu"), "tree_exited")
	theme = load(g.theme)
	$bg.texture = load(g.bg)



func _on_lobby_pressed():
	loader.load_scene("res://environment/minigames/lobby/lobby.tscn", self)


func _on_option_pressed():
	$ui.toggle_menu(load("res://ui/settings.tscn"))
