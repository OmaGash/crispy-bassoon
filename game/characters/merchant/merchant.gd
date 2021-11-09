extends StaticBody
class_name Merchant
#All interactables will need to have an _interact() function, which will contain all
#of the interactions that the object will respond such as dialogs.
var choice
func _interact(player):
	#Dialogic.set_variable("name", g.player_name)
#	var dialog = Dialogic.start("test1", false)
	#print(Dialogic.get_definitions())
	#print(Dialogic.get_variable("name"))
#	add_child(dialog)
	var dialogic = Dialogic.start("shop")
	dialogic.connect("dialogic_signal", self, "_after_dialog")
	add_child(dialogic)
	yield(dialogic, "timeline_end")
	match choice:
		0:
			get_parent().get_node("ui").toggle_menu(load("res://ui/shop.tscn") as PackedScene)
		_:
			player.current_state = 0

func _after_dialog(choiced):
	match choiced:
		"shop":
			choice = 0
		_:
			choice = 1
