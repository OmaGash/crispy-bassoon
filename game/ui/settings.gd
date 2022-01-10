extends Control

func _ready():
	if !g.is_desktop:
		for node in get_tree().get_nodes_in_group("desktop"):
			node.queue_free()
	else:
		$PanelContainer/MarginContainer/actual_menu/options/touch.pressed = g.is_mobile
		$PanelContainer/MarginContainer/actual_menu/options/fullscreen.pressed = OS.window_fullscreen
	$PanelContainer/MarginContainer/actual_menu/options/HBoxContainer/music.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("bgm"))) * 100
	$PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/sfx.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("environment"))) * 100
	$PanelContainer/MarginContainer/actual_menu/options/language.selected = 0 if TranslationServer.get_locale() == "en" or TranslationServer.get_locale() == "en_US" else 1
	print(TranslationServer.get_locale())

func _on_close_pressed():
	get_parent().toggle_menu(load("res://ui/settings.tscn"))


func _on_HSlider_value_changed(value):#SFX
	$"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/value".text = str(int(round($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/sfx".value))) + "%"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("player"), linear2db($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/sfx".value * 0.01))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("environment"), linear2db($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer2/sfx".value * 0.01))
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("player"), true)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("environment"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("player"), false)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("environment"), false)

func _on_HSlider0_value_changed(value):#Music
	$"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer/value".text = str(int(round($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer/music".value))) + "%"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), linear2db($"PanelContainer/MarginContainer/actual_menu/options/HBoxContainer/music".value * 0.01))
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("bgm"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("bgm"), false)


func _on_language_item_selected(index):
	match $PanelContainer/MarginContainer/actual_menu/options/language.selected:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("fil")


func _on_touch_toggled(button_pressed):
	g.is_mobile = button_pressed


func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
