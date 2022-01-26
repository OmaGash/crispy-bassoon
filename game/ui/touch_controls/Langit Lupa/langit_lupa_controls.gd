extends Control


func _ready():
	if not g.is_mobile:
		queue_free()
