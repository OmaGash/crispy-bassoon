extends Node
#Global variables and functions

signal toggle_menu
signal new_pearls

var player_name = "xXDesTr00yerXx" setget _change_name
var artifact_passive = 3 #Passive unlocks
var artifact_active = 2 #active unlocks
var current_artifacts = [-1, -1] setget _artifact_swap
var in_game = false
var pearls = 50 setget update_pearls
var difficulty#0, 1, 2
var theme = "res://ui/themes/default.tres"
var is_mobile = false#for touch controls
const is_desktop = true#set to true if desktop export
const debug = false
#Where the entries are kept
var entries:Dictionary = {
	0: {
		"name": "Siyokoy",
		"description" :"siyokoy_description" ,
		"icon": "res://ui/icons/creature icons/siyokoy-icon.png",
		"owned": false,
		"theme": "res://ui/themes/shokoy.tres",
		"price": 50,
		"fax": {
			"image": "res://ui/icons/creature reward/siyokoy-reward.png",
			"video": "res://icon.mkv",
			"info": "siyokoy_info"
		}
		},
	1: {
		"name": "Santelmo",
		"description" : "santelmo_description",
		"icon": "res://ui/icons/creature icons/santilmo-icon.png",
		"owned": false,
		"theme": "res://ui/themes/santilmo.tres",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image": "res://ui/icons/creature reward/santilmo-reward.png",
			"video": "none",
			"info": "santelmo_info"
			}
		},
	2: {
		"name": "Tikbalang",
		"description" : "tikbalang_description",
		"icon":"res://ui/icons/creature icons/tikbalang-icon.png" ,
		"owned": false,
		"theme": "res://ui/themes/tikbalang.tres",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image": "res://ui/icons/creature reward/tikbalang-reward.png",
			"video": "none",
			"info": "tikbalang_info"
			}
		},
	3: {
		"name": "Duwende",
		"description" : "duwende_description",
		"icon":"res://ui/icons/creature icons/dwende-icon.png",
		"owned": false,
		"theme": "res://ui/themes/duwende.tres",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/dwende-reward.png" ,
			"video": "none",
			"info": "duwende_info"
			}
		},
	4: {
		"name": "Aswang",
		"description" : "aswang_description",
		"icon": "res://ui/icons/creature icons/aswang-icon.png",
		"owned": false,
		"theme":"res://ui/themes/aswang.tres",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/aswang-reward.png" ,
			"video": "none",
			"info": "aswang_info"
			}
		},
	5: {
		"name": "Manananggal",
		"description" :"mana_description",
		"icon": "res://ui/icons/creature icons/manananggal-icon.png",
		"owned": false,
		"theme": "res://ui/themes/manananggal.tres",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/manananggal-reward.png" ,
			"video": "none",
			"info": "mana_info"
			}
		},
	6: {
		"name": "Kapre",
		"description" : "kapre_description",
		"icon":"res://ui/icons/creature icons/kapre-icon.png" ,
		"owned": false,
		"theme": "res://ui/themes/kapre.tres",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/kapre-reward.png" ,
			"video": "none",
			"info": "kapre_info"
			}
		},
	7: {
		"name": "Sirena",
		"description" : "sirena_description",
		"icon":"res://ui/icons/creature icons/sirena-icon.png" ,
		"owned": false,
		"theme":"res://ui/themes/sirena.tres" ,
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/sirena-reward.png" ,
			"video": "none",
			"info": "sirena_info"
			}
		},
	8: {
		"name": "Engkanto",
		"description" : "engkanto_description",
		"icon":"res://ui/icons/creature icons/engkanto-icon.png" ,
		"owned": false,
		"theme":"res://ui/themes/engkanto.tres" ,
		"price": 50,
		"fax": {#use "none" pag n/a
			"image": "res://ui/icons/creature reward/engkanto-reward.png",
			"video": "none",
			"info": "engkanto_info"
			}
		},
	
	}


func _ready():#This node will run regardless of pausing
	pause_mode = Node.PAUSE_MODE_PROCESS
	load_save()

func _change_name(new_name: String):
	player_name = new_name
	Dialogic.set_variable("player_name", new_name)

func _input(event):
	if event.is_action_pressed("ui_cancel") and in_game:
		#pause()
		emit_signal("toggle_menu", load("res://ui/pause_menu.tscn"))
	if event.is_action_pressed("artifax") and in_game:
		#pause()
		emit_signal("toggle_menu", load("res://ui/artifax/artifax.tscn"))

func pause():
	get_tree().paused = true if !get_tree().paused else false

func _artifact_swap(new_artifacts):
	current_artifacts = new_artifacts
	if has_node("/root/world"):
		if has_node("/root/world/player"):
			$"/root/world/player".update_blessings(new_artifacts)

func update_pearls(new_value):
	pearls = new_value
	emit_signal("new_pearls", pearls)

#Save system------------------------------------------------------------------------------------------------------------------------------------------

const save_filename = "user://data.sav"

func save():
	var save_file = File.new()
	var key = generate_key()
	save_file.open_encrypted_with_pass(save_filename, 2, key)
	#not necessary since we only have global node to save
#	var nodes_to_save = get_tree().get_nodes_in_group("saved")
#	for node in nodes_to_save:
#		if node.filename.empty():
#			break
#		var values_to_save = node.get_values()
	save_file.store_line(to_json(get_values()))
	save_file.close()

func load_save():#Load save file
	var save_file = File.new()
	if not save_file.file_exists(save_filename):
		return
	save_file.open_encrypted_with_pass(save_filename, 1, get_key())
	while save_file.get_position() < save_file.get_len():
		var data = parse_json(save_file.get_line())
		load_values(data)

func get_values():
	return{
		"pearls": pearls,
		"entries": entries,
		"theme": theme
	}

func load_values(data: Dictionary):
	pearls = data["pearls"]
	entries.clear()
	entries = data["entries"] as Dictionary
	var intkey = 0
	for key in entries.keys():#Converts keys to int
		entries[intkey] = entries[key]
		entries.erase(key)
		intkey += 1
	theme = data["theme"]
	print(theme)
func delete_save():
	var savefile = File.new()
	if savefile.file_exists(save_filename):
		var dir = Directory.new()
		dir.remove(save_filename)

func generate_key():#Generate a password for file
	var key_file = File.new()
	var pattern = str(hash(OS.get_unique_id() + str(OS.get_time())))#Makes sure that a new unique key is generated when saving
	key_file.open("user://misc",2)
	key_file.store_line(pattern)
	key_file.close()
	return pattern

func get_key() -> String:
	var key_file = File.new()
	if not key_file.file_exists("user://misc"):#Dont load data when no key is found
		return ""
	key_file.open("user://misc", 1)
	var key = key_file.get_line()
	key_file.close()
	return key
