extends ScrollContainer

signal game_selected

export(float, 0.5, 1, 0.1) var button_scale = 1
export(float, 1, 1.5, 0.1) var current_button_scale = 1.3
export(float, 0.1, 1, 0.1) var scroll_duration = 1.3

var button_current_index: int = 0
var button_x_positions: Array = []

onready var scroll_tween: Tween = Tween.new()
onready var margin_r: int = $selection/MarginContainer.get("custom_constants/margin_right")
onready var button_space: int = $selection/MarginContainer/HBoxContainer.get("custom_constants/separation")
onready var button_nodes: Array = $selection/MarginContainer/HBoxContainer.get_children()
onready var anim: AnimationPlayer = $"../anim"

func _ready() -> void:
	add_child(scroll_tween)
	yield(get_tree(), "idle_frame")
	
	get_h_scrollbar().modulate.a = 0
	
	for _button in button_nodes:
		var _position_x_button: float = (margin_r + _button.rect_position.x) - ((rect_size.x - _button.rect_size.x) / 2)
		_button.rect_pivot_offset = (_button.rect_size / 2)
		button_x_positions.append(_position_x_button)
		
	scroll_horizontal = button_x_positions[button_current_index]
	scroll()


func _process(delta: float) -> void:
	for _index in range(button_x_positions.size()):
		var _position_x_button: float = button_x_positions[_index]
		var _swipe_length: float = (button_nodes[_index].rect_size.x / 2) + (button_space / 2)
		var _swipe_current_length: float = abs(_position_x_button - scroll_horizontal)
		var _button_scale: float = range_lerp(_swipe_current_length, _swipe_length, 0, button_scale, current_button_scale)
		var _button_opacity: float = range_lerp(_swipe_current_length, _swipe_length, 0, 0.3, 1)
		
		_button_scale = clamp(_button_scale, button_scale, current_button_scale)
		_button_opacity = clamp(_button_opacity, 0.3, 1)
		
		button_nodes[_index].rect_scale = Vector2(_button_scale, _button_scale)
		button_nodes[_index].modulate.a = _button_opacity
		
		if _swipe_current_length < _swipe_length:
			button_current_index = _index


func scroll() -> void:
	scroll_tween.interpolate_property(
		self,
		"scroll_horizontal",
		scroll_horizontal,
		button_x_positions[button_current_index],
		scroll_duration,
		Tween.TRANS_BACK,
		Tween.EASE_OUT)
	
	for _index in range(button_nodes.size()):
		var _button_scales: float = current_button_scale if _index == button_current_index else button_scale
		scroll_tween.interpolate_property(
			button_nodes[_index],
			"rect_scale",
			button_nodes[_index].rect_scale,
			Vector2(_button_scales,_button_scales),
			scroll_duration,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT)
		
	scroll_tween.start()


func _on_ScrollContainer_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			scroll_tween.stop_all()
		else:
			scroll()


func _on_palosebo_pressed():
	anim.play("up")
	emit_signal("game_selected", "palo")


func _on_sipa_pressed():
	anim.play("up")
	emit_signal("game_selected", "sipa")


func _on_luksongbaka_pressed():
	anim.play("up")
	emit_signal("game_selected", "baka")


func _on_langitlupa_pressed():
	anim.play("up")
	emit_signal("game_selected", "langit")
