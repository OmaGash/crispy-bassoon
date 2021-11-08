extends CanvasLayer


func _ready():
	pass


func update_score(player_score, npc_score):
	$TextureRect/HBoxContainer/player_score.text = "Player score: " + str(player_score)
	$TextureRect/HBoxContainer/npc_score.text = "NPC score: " + str(npc_score)
#	$TextureRect/HBoxContainer/player_score.text = "Player Score: " + str(player_score)
#	$TextureRect/HboxContainer/npc_score.text = "Enemy Score: " + str(npc_score)
	
