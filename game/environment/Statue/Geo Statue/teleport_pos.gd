extends Position3D

onready var player = get_parent().get_node("player")

func interact(is_off):
	if is_off:
		player.set_deferred('translation', $Position3D.translation)
