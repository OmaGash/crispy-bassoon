extends CanvasLayer
#Handles what menu to display
#Attach this to a CanvasLayer ui node as the root node's child
#Then set the ui node's pause mode to process
#Then set global's in_game variable to true
#Menus need to have an AnimationPlayer node named "anim" with an animation named "fade" for this to work properly.
class_name UI
var menu_is_open = false

func _ready():
	yield(loader, "done")
	g.connect("toggle_menu", self, "toggle_menu")
	var pause_button: = TextureButton.new()
	pause_button.texture_normal = load("res://ui/icons/play-pause-flat-hd.png") as Texture
	pause_button.rect_scale = Vector2(.067,.067)
	pause_button.connect("pressed", self, "_pause_pressed")
	add_child(pause_button)
	loader.connect("loading", pause_button,"queue_free")#delet pause when loading

func toggle_menu(menu:PackedScene):#Called from global.gd, may be called from anywhere.
	
	if not menu_is_open:
		var new_menu = menu.instance()
		new_menu.name = "submenu"
		add_child(new_menu)
		if not get_node("submenu").has_node("anim"):
			var warning = load("res://ui/warning.tscn").instance()
			add_child(warning)
			warning.warn(get_tree(), "Menu does not have an animation node, you may ignore this but do consider adding one.", "submenu node error")
			yield(warning, "confirmed")
			menu_is_open = true
			return
		get_node("submenu").get_node("anim").play("fade")
		menu_is_open = true
		get_tree().paused = true
		yield(get_node("submenu").get_node("anim"), "animation_finished")
	else:
		if has_node("submenu"):#Close menu
#			print("laskdj")
			if not get_node("submenu").has_node("anim"):#Make anim node mandatory for consistency
				var warning = load("res://ui/warning.tscn").instance()
				add_child(warning)
				warning.warn(get_tree(), "Menu does not have an animation node, you may ignore this but do consider adding one.", "submenu node error")
				get_node("submenu").queue_free()
				menu_is_open = false
				return
			get_node("submenu").get_node("anim").play_backwards("fade")
			get_tree().paused = false
			yield(get_node("submenu").get_node("anim"), "animation_finished")
			get_node("submenu").queue_free()
			menu_is_open = false
func _on_menu_pressed():
	var a = InputEventAction.new()
	a.action = "artifax"
	a.pressed = true
	Input.parse_input_event(a)

func _pause_pressed():
	var a = InputEventAction.new()
	a.action = "ui_cancel"
	a.pressed = true
	Input.parse_input_event(a)
