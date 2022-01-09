extends Spatial

var score: int = 0 setget newscore

func ready():
	var os = OS.get_name()
	if os == 'Windows':
		$"Sipa-Controls".get_child(0).hide()
		$"Sipa-Controls".get_child(1).hide()
		$"Sipa-Controls".get_child(2).hide()
func newscore(value):
	score=value
	$"ui/Label".text= tr("ui_score").format({score = score})

