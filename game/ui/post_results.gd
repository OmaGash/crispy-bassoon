extends Control
class_name PostResult
#add this to the winning/losing statement
#toggle_menu(load("res://ui/post_results.tscn"))
#if has_node("submenu"):
#	get_node("submenu").set_values(result, info, pearls_won)
func set_values(result: String, info: String, pearls: int):
	$PanelContainer/items/result.text = result
	$PanelContainer/items/info.text = info
	$PanelContainer/items/pearls.text = "You have won " + str(pearls) + " pearl(s)." if pearls > 0 else ""#Display nothing pag lose
	g.pearls += pearls


func _on_done_pressed():
	get_parent().toggle_menu(load("res://ui/post_results.tscn") as PackedScene)
	loader.load_scene("res://ui/main_menu.tscn", get_parent().get_parent())


func _on_retry_pressed():
	print(get_parent().get_parent().filename)
	g.pause()
	$anim.play_backwards("fade")
	yield($anim, "animation_finished")
	loader.load_scene(get_parent().get_parent().filename, get_parent().get_parent())
	
