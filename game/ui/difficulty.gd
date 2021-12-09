extends Control
#USAGE
#instance this node as the last child of the game's ui node
#add $"ui/difficulty".connect("tree_exited", self, "difficulty_selected") to the game scene's _ready function
#difficulty_selected will contain the code for modifying the game's difficulty
signal difficulty_set
#Pause game if not paused already
func _ready():
	loader.connect("done", self, "pause")

func pause():
		get_tree().paused = true
func fade():
	$anim.play("fade")
	yield($anim, "animation_finished")
	queue_free()
	get_tree().paused = false
	emit_signal("difficulty_set")

func _on_ez_pressed():
	g.difficulty = 0
	fade()

func _on_ezz_pressed():
	g.difficulty = 1
	
	fade()


func _on_ezz2_pressed():
	g.difficulty = 2
	
	fade()
