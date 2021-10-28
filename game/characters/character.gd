extends KinematicBody
#All character classes will inherit this script.
class_name Character, "res://icon.png"

signal state_changed

#This will define how heavy the character will be
var _gravity: = 9.807
#Jump force (pun intended)
var _jump_force = 15
#Can it jump?
var can_jump = true
#Character's flat movement speed
var _speed: = 2.0
#The character's max HP, we will have a 1 damage to all attacks with some exceptions.
var _max_hp: = 3
var current_hp:= _max_hp

#The character's affiliation
enum{
	PLAYER, 
	ENEMY
}

#Finite states
enum _state{
	IDLE,#For when the character is not moving.
	MOVE,#For when the character is moving.
	FALL,#For when the character is falling.
	JUMP,#For when the character receives damage.
	ABNORMAL,#For when the character is stunned, slowed, etc.
	INTERACT,#For Players only, when they interact with NPCs and events.
	ALERT#For NPCs only, when they go vigilante against the player.
}
#Default state will be idle
var current_state = _state.IDLE setget _change_state
var _previous_state = current_state

#Changes the state if it's different from the current one
func _change_state(_new_state):
	if _new_state != current_state:
		_previous_state = current_state#Save the last state to prev state.
		current_state = _new_state
		emit_signal("state_changed", current_state)
		#print(current_state)
