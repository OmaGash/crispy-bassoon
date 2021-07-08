extends Button
var mc_scn = preload("res://mc.tscn")
func _ready() -> void:
	pass



func _on_test_pressed() -> void:
	var mc = mc_scn.instance()
	get_tree().root.get_child(0).add_child(mc)
	$"../body".count += 1
