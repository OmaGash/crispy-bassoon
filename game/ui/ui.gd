extends CanvasLayer
#Handles what menu to display
#Attach this to a CanvasLayer ui node as the root node's child
#Then set the ui node's pause mode to process

var menu_is_open = false

func _ready():
	g.connect("toggle_menu", self, "toggle_menu")

func toggle_menu(menu:PackedScene):#Called from global.gd
	if not menu_is_open:
		var new_menu = menu.instance()
		new_menu.name = "submenu"
		add_child(new_menu)
		menu_is_open = true
	else:
		if has_node("submenu"):
#			print("laskdj")
			get_node("submenu").queue_free()
			menu_is_open = false

func _process(delta):
	$debug/states/vbox/fps.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))#these 2 lines are for debugging only, remove as needed
	$debug/states/vbox/offer.text = "Has offer: " + str($"../player".hasoffer)

func _on_menu_pressed():
	var a = InputEventAction.new()
	a.action = "artifax"
	a.pressed = true
	Input.parse_input_event(a)
