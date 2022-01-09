extends Control

func _ready():
	if !g.is_desktop:
		for node in get_tree().get_nodes_in_group("desktop"):
			node.queue_free()
		

func _on_close_pressed():
	get_parent().toggle_menu(load("res://ui/settings.tscn"))


func _on_HSlider_value_changed(value):
	$"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/value".text = str(int(round($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/HSlider".value))) + "%"


func _on_HSlider0_value_changed(value):
	$"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer/value".text = str(int(round($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer/HSlider".value))) + "%"
	


func _on_language_item_selected(index):
	match $PanelContainer/MarginContainer/actual_menu/options/language.selected:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("fil")


func _on_touch_toggled(button_pressed):
	g.is_mobile = button_pressed
