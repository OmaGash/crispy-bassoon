extends Spatial

func _ready():
	g.in_game = true
	gd.stop_main_theme()
	for creature in range(g.entries.size()):
		if not g.entries[creature]["owned"]:#Check if the creature is owned
			print(g.entries[creature]["name"])
			get_node(g.entries[creature]["name"]).queue_free()#Delete if not
