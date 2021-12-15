extends Control


var next_scene="res://environment/minigames/palo_sebo/palo_sebo.tscn"
var return_scene="res://ui/main_menu.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_pressed():
	loader.load_scene(next_scene, self)


func _on_cancel_pressed():
	loader.load_scene(return_scene,self)
