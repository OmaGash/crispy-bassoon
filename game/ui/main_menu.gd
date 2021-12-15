extends Control

var next_scene := "res://protopyte/za_warudo/world.tscn"
var pre_scenes := {
	"palo_sebo": preload("res://ui/pre/pre-palo_sebo.tscn"),
	"langit_lupa": preload("res://ui/pre/pre-langit_lupa.tscn"),
	"sipa": preload("res://ui/pre/pre-sipa.tscn"),
	"luksong_baka": preload("res://ui/pre/pre-luksongbaka.tscn")
}
var shop = preload("res://ui/shop.tscn")
onready var preview := $PanelContainer/categories/preview/preview_contents/actual_content/actual_actual_content

func _ready():
	g.in_game = false
	theme = load(g.theme) as Theme if g.theme != "n/a" else null

func _on_start_pressed():
	$anim.play("open_selection")


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

func load_preview(which_scene: PackedScene):
	if preview.get_child_count() > 0:
		for child in preview.get_children():
			child.queue_free()
	preview.add_child(which_scene.instance())

func _on_palo_pressed():
	load_preview(pre_scenes["palo_sebo"])

func _on_sipa_pressed():
	load_preview(pre_scenes["sipa"])


func _on_shato_pressed():
	load_preview(pre_scenes["luksong_baka"])


func _on_langit_pressed():
	load_preview(pre_scenes["langit_lupa"])


func _on_close_pressed():
	$anim.play_backwards("open_selection")
	yield($anim, "animation_finished")
	$PanelContainer.visible = false


func _on_shop_pressed():
	$ui.toggle_menu(load("res://ui/shop.tscn"))

