extends Spatial

var score: int = 0 setget newscore

func newscore(value):
	score=value
	$"ui/Label".text=str(score)

