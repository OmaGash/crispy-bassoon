extends Spatial

func _ready():
	g.in_game = true
	if !g.is_mobile:
		$LangitLupaControls.queue_free()
	gd.stop_main_theme()
	for creature in range(g.entries.size()):
		if not g.entries[creature]["owned"]:#Check if the creature is owned
			print(g.entries[creature]["name"])
			get_node(g.entries[creature]["name"]).queue_free()#Delete if not
	
	#connect all creatures to one node
	for creature in get_tree().get_nodes_in_group("creatures"):
		creature.connect("body_entered", self, "_player_entered", [creature])
		creature.connect("body_exited", self, "_player_exited", [creature])

func _player_entered(body, creature):
	if body.name == "player":
		var anim = Tween.new()
		add_child(anim)
		anim.interpolate_property(creature.get_node("label"), "opacity", null, 1, 1)
		anim.start()
		yield(anim, "tween_completed")
		anim.queue_free()

func _player_exited(body, creature):
	if body.name == "player":
		var anim = Tween.new()
		add_child(anim)
		anim.interpolate_property(creature.get_node("label"), "opacity", null, 0, 1)
		anim.start()
		yield(anim, "tween_completed")
		anim.queue_free()
