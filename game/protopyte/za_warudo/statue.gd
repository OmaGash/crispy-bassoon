extends Area

export var link:NodePath

onready var link_noded: = get_node(link)

var is_off: bool = true#If statue is deactivated
var is_interacting = false

func _ready():
	if link_noded==null:
		print(name + " linked node was not assigned.")
		return
	
func _interact(player):
	if link_noded==null:
		print(name + " linked node was not assigned.")
		return
	if is_off:
		if player.hasoffer==true:
			if link_noded.has_method("interact")==true:
				is_interacting = true
				print("asjdllasdj")
				link_noded.call("interact", is_off)
				is_off = false
				yield(link_noded, "done")
				player.current_state=0
				player.hasoffer = false
		else:
			pass#Tell player that he needs an offer
	else:
		if player.hasoffer == false:
			if link_noded.has_method("interact")==true:
				is_interacting = true
				link_noded.call("interact", is_off)
				is_off = true
				yield(link_noded, "done")
				player.current_state=0
				player.hasoffer = true
		else:#If player already has offer
			pass#Tell player that he cant have more than 1 offer at hand

