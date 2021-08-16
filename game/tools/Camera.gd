extends Camera
#The camera needs to be at the top of the root node's children.
#Then assign the player scene to the camera so the camera would be able to follow the player.

export var player_scene: NodePath #Add the player scene from the editor
export var smoothing_offset: Vector3 # The point where the camera will move

onready var player_node: Character = get_node(player_scene)

func _ready():
	if player_node == null:
		print("I think you forgot to assign the player in the Camera node's inspector.")
		set_process(false)
	current = true

func _process(delta: float):
	#TODO: Add offset then smoothing
	translation.x = player_node.translation.x
	translation.y = player_node.translation.y + 4
