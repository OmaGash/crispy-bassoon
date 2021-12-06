extends Control
#USAGE
#instance this node as the last child of the game's ui node
#add $"ui/difficulty".connect("tree_exited", self, "difficulty_selected") to the game scene's _ready function
#difficulty_selected will contain the code for modifying the game's difficulty


func _on_ez_pressed():
	g.difficulty = 0
	$anim.play("fade")
	yield($anim, "animation_finished")
	queue_free()


func _on_ezz_pressed():
	g.difficulty = 1
	$anim.play("fade")
	yield($anim, "animation_finished")
	queue_free()


func _on_ezz2_pressed():
	g.difficulty = 2
	$anim.play("fade")
	yield($anim, "animation_finished")
	queue_free()
