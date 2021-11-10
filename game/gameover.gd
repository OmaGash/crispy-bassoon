extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_PlayAgainButton_pressed():
	get_parent().reset_game()


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://ui/main_menu.tscn")
	pass # Replace with function body.
