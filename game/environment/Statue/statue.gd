extends Area
class_name Statue, "res://characters/concept/statue/statue-earth.png"
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
	if is_off:#If statue is disabled
		if player.hasoffer==true:
			if link_noded.has_method("interact")==true:
				is_interacting = true
				link_noded.call("interact", is_off)
				is_off = false if not is_in_group("geo") else true
				yield(link_noded, "done")
				player.current_state=0
				player.hasoffer = false if not is_in_group("geo") else true
		else:
			print("offer plz")
			player.current_state = 0#Tell player that he needs an offer
	else:#If statue is enabled
		if player.hasoffer == false:
			if link_noded.has_method("interact")==true:
				is_interacting = true
				link_noded.call("interact", is_off)
				is_off = true
				yield(link_noded, "done")
				player.current_state=0
				player.hasoffer = true if not is_in_group("geo") else false
		else:#If player already has offer
			print("dont be greedy")#Tell player that he cant have more than 1 offer at hand

