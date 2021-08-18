extends Camera
#The camera needs to be at the bottom of the root node's children.
#Then assign the player scene to the camera so the camera would be able to follow the player.

export var player_scene: NodePath #Add the player scene from the editor
export var follow_x: bool = true#Whether the camera will follow the player on the x axis
export var follow_y: bool = true#Whether the camera will follow the player on the y axis
export var follow_offset: Vector2 = Vector2(0,0)# The point where the camera will move
export var smoothing: float = .01

onready var player_node: Character = get_node(player_scene) if has_node(player_scene) else null

func _ready():
	if player_node == null:
		print("/tools/camera.gd: I think you forgot to assign the player in the Camera node's inspector.")
		var warning_scn: PackedScene = load("res://ui/warning.tscn")
		var warning: Warning = warning_scn.instance(PackedScene.GEN_EDIT_STATE_INSTANCE)
		
		if get_parent().has_node("ui"):
			get_parent().get_node("ui").add_child(warning)
		set_process(false)
		warning.warn("Assign the player node  to the camera via inspector.", "Camera Node Error", true)
	current = true

func _process(delta: float):
	#TODO: Add offset then smoothing
	
	#Check if the player's x is getting to the screen's edge
	if follow_x:
		if player_node.translation.x < translation.x - follow_offset.x:#Left offset
			translation.x = lerp(translation.x, player_node.translation.x + follow_offset.x, smoothing)
		if player_node.translation.x > translation.x + follow_offset.x:#Right offset
			translation.x = lerp(translation.x, player_node.translation.x - follow_offset.x, smoothing)
	if follow_y:
		if player_node.translation.y < translation.y - follow_offset.y:#Left offset
			translation.y = lerp(translation.y, player_node.translation.y + follow_offset.y, smoothing)
		if player_node.translation.y > translation.y + follow_offset.y:#Right offset
			translation.y = lerp(translation.y, player_node.translation.y - follow_offset.y, smoothing)
#	translation.x = player_node.translation.x
#	translation.y = player_node.translation.y + 4
