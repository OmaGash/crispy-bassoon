extends Node

"""
Rules:
	1. Player takes everything from one pit from their side of the board.
	2.0 Player distributes the pit's pebbles to every other pits clockwise.
	2.1 Player also distributes pebbles to their own store, skipping the enemy's.
	3.0 If last pebble lands on an occupied pit, repeat step 1.
	3.1 If last pebble lands on an empty pit, end turn.
	4. Repeat until all pits are empty.
Winning Condition:
	Whoever gathers more pebbles at the end of the game wins.
"""
var pebble = preload("res://icon.png")

var pits = [7, 7, 7, 7, 7, 7, 7]
var first: int #Who moves first

func _ready() -> void:
	randomize()
	first = randi() % 2 #0 Will be enemy, 1 is player

func _process(delta: float) -> void:
	var hand := 0 #How much pebbles are in queue for distribution

func turn_player(pit):
	var player_pits = pit
	return player_pits

func turn_enemy():
	pass

func pass_pebbles(pit1, pit2, pebbles):
	pass
