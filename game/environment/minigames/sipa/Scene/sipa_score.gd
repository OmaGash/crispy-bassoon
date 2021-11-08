extends CanvasLayer



func update_score(score):
	var score_label = get_node("HBoxContainer/Label")
	score_label.text = str(score)
	


func _on_Timer_ready():
	$Timer.autostart = true


func _on_Timer_timeout():
	pass # Replace with function body.
