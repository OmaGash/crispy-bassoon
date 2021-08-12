extends KinematicBody
#All character classes will inherit this script.
class_name Character, "res://characters/player/portrait.jpg"

#This will define how heavy the character will be
var _gravity: = 9.807
#Jump force (pun intended)
var _jump_force = 10
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
	ATTACK,#For when the character is attacking.
	DAMAGED,#For when the character receives damage.
	ABNORMAL,#For when the character is stunned, slowed, etc.
	ALERT#For NPC's only, when they go vigilante against the player.
}
#Default state will be idle
var current_state = _state.IDLE setget _change_state
var _previous_state = current_state

#Changes the state if it's different from the current one
func _change_state(_new_state):
	if _new_state != current_state:
		_previous_state = current_state#Save the last state to prev state.
		current_state = _new_state
		print(current_state)