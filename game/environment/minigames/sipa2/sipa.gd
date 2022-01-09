extends Spatial

var score: int = 0 setget newscore

func _ready():
	
	if true == g.is_mobile:
		$"Sipa-Controls".get_child(0).queue_free()
		$"Sipa-Controls".get_child(1).queue_free()
		$"Sipa-Controls".get_child(2).queue_free()
	$"ui/PanelContainer/Label".text= tr("ui_score").format({score = score})
func newscore(value):
	score=value
	$"ui/PanelContainer/Label".text= tr("ui_score").format({score = score})

