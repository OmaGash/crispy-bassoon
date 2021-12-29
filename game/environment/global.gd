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
var theme = "n/a"

#Where the entries are kept
var entries:Dictionary = {
	0: {
		"name": "Siyokoy",
		"description" : "The Siyokoy are fearsome merfolk.\nThey are aquatic creatures with a humanoid form and scaled fish-like bodies.\n On different areas of their body, they have wide green tentacles and fins.\n They have gill slits, webbed hands, and are brown or green in appearance.",
		"icon": "res://ui/icons/creature icons/siyokoy-icon.png",
		"owned": false,
		"theme": "res://shokoy.tres",
		"price": 50,
		"fax": {
			"image": "res://ui/icons/creature reward/siyokoy-reward.png",
			"video": "res://icon.mkv",
			"info": "They are sea creatures that are believed to drown and swallow mortals.\n They are widely accused of causing ocean disasters.\n Eels, octopus, rays, and squids, among many other threatening aquatic species,\n usually swim along Siyokoy."
		}
		},
	1: {
		"name": "Santilmo",
		"description" : "A ball of fire.",
		"icon": "res://icon.png",
		"owned": false,
		"theme": "n/a",
		"price": 69,
		"fax": {#use "none" pag n/a
			"image": "res://characters/concept/aeta.png",
			"video": "none",
			"info": "Santelmo is believed to be a lost spirit who manifests as a fiery ball.\n This sort of story is well-known in rural areas around the Philippines.\n According to mythology, if a man drowns in water, such as a river, sea, or rain,\n his soul will stay in the area where he perished.\n The lost souls will stay in mortal lands, wanting revenge or help from the people.\n There are souls who are looking for peace for their souls and asking for help or\nprayers in order to enter heaven.\n It has the appearance of a torch with a brilliant light, and it is shaped like a ball of fire.\n It is said that if you follow the light,\n you would never be able to return until someone sees you and saves you from losing. "
			}
		},
	2: {
		"name": "Tikbalang",
		"description" : " It is a bipedal horse creature of Philippine folklore \nsaid to lurk in the mountains and forests of the Philippines.",
		"icon": "res://icon.png",
		"owned": false,
		"theme": "n/a",
		"price": 69,
		"fax": {#use "none" pag n/a
			"image": "none",
			"video": "none",
			"info": "The Tikbalang appears as a tall, bony creature resembling a humanoid horse.\n It is covered with a fluffy dark mane,while its fur is a lighter color.\n They are said to terrify travelers or play tricks on them, luring them astray from the correct path.\n No matter how far the traveler goes or where he turns, such techniques\n will prevent him from returning to the road. Traditional folklore says that the Tikbalang may shift\n into human form or become invisible to humans. "
			}
		},
	3: {
		"name": "Dwende",
		"description" : "A dwende, or 'old man on the mound'is a dwarf creature who lives in the woods,\nin an anthill or old houses in a remote areas.",
		"icon":"res://ui/icons/creature icons/dwende-icon.png",
		"owned": false,
		"theme": "n/a",
		"price": 69,
		"fax": {#use "none" pag n/a
			"image": "none",
			"video": "none",
			"info": "Dwende are said to have a fondness for females. They carried her out to their paradise.\nThe body will be turned asleep.\nThey usually come to visit in a lighthearted manner, depending on their mood.\nOthers claim they won't let you eat, won't let you speak, and will keep you sluggish until you fall\nill.\nDifferent Types of Dwende\n\nThere are two types of dwende: good & evil. These hidden dwarves appear to be colored\ndifferently based on their personality.  Red is the color of evil dwende. It might be quite\nbad if you have an evil red dwende dwelling in your house. The easiest approach to get rid\nof them is to perform a ritual that an albularyo(Healer) can perform. There are different colors\nof dwende like White and Green.Dwende, like humans, and other unseen creatures, demand\nrespect. Many people in the Philippines are frightened about the prospect of harming or\nupsetting Dwende, particularly given their ability to curse humans. Because they are invisible,\nit is quite easy to insult them. It is also very difficult to tell if they are there at an\ninconvenient time. As a reason, many Filipinos prefer to say excuse me before peeing or tossing\nout unclean water,fearing that it will land on the dwende's head and irritate him."
			}
		},
	4: {
		"name": "Aswang",
		"description" : "Another folktale recited by Filipino ancestors from generation to generation, particularly\nin rural areas, is Aswang. People are still conservative and oblivious to modern technology in these\nareas. ",
		"icon": "res://icon.png",
		"owned": false,
		"theme": "n/a",
		"price": 69,
		"fax": {#use "none" pag n/a
			"image": "none",
			"video": "none",
			"info": "Aswang rely on food to survive. They are attracted to human organs such as the heart and liver,\nand also fresh blood, fetuses, and the bodies of the deceased. Women who are pregnant are\ntheir preferred prey. To bewilder people, they mimic an animal such as a dog, cat, or bird.\nThey can sneak up on you unnoticed.The majority of pregnant women used to carry a bullet to\nfend off an aswang attack. While on the hunt for a victim, Aswang was supposed to have a buddy\ntiktik, or tikling, a bird. When you hear the sounds of tiktik or kikik, it only means one thing: an\naswang is close by. Staying up late at night looking for those who have died. And then take it."
			}
		},
	5: {
		"name": "Manananggal",
		"description" : "From the tagalog word of ‘’ tanggal’’ or to split. It is believed that they split or separate half of\ntheir body, to hunt for food.",
		"icon": "res://ui/icons/creature icons/manananggal-icon.png",
		"owned": false,
		"theme": "n/a",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/manananggal-reward.png" ,
			"video": "none",
			"info": "They seek for the same food as aswangs, fresh blood, fetuses, and human parts, particularly\nthe heart and liver.While they are out hunting at night, Manananggal transforms into a terrifying\ncreature with a wrinkled face, sharp claws and teeth, and frighteningly large eyes.As well\nas a huge wings to fly. The lower body was left to stand on the ground. They will take to the\nskies in quest of food, sucking blood or eating the fetus of a pregnant lady with their elongated\nsharp tongue.To keep manananggal at bay, put salt throughout your home; they also detest\ngarlic, the tail of a sting ray, and sunlight. They must reunite to their half body before daylight, or\nthey will perish. They will be burned by the sun."
			}
		},
	6: {
		"name": "Kapre",
		"description" : "The kapre is a cryptid monster from the Philippines that resembles a tremendously tall,\nlong-legged, god-like hairy humanoid that rests in lofty trees and smokes tobacco.",
		"icon":"res://ui/icons/creature icons/kapre-icon.png" ,
		"owned": false,
		"theme": "n/a",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/kapre-reward.png" ,
			"video": "none",
			"info": "It is described as being tall (between 7 to 9 ft), brown, hairy male with a beard. Unlike the\nManananggal, Kapres are not always thought to be evil. According to some reports, the kapre\nhave transitioned from smoking near-infinite cigars to drinking beer. Some kapre are smart,\nwhile others are feared beasts, but they all have one thing in common: an unusual need to keep\nan eye on farm animals and humans.Kapres are also claimed to play practical jokes on people,\ncausing them to become confused and lose their way in the mountains or woodlands. They are\nalso thought to be capable of puzzling people even in familiar surroundings; for example,\nsomeone who forgets they are in their own yard or home is said to have been fooled by a kapre.\nIf Kapres is attracted to a woman, it may establish contact with them to offer friendship. If a\nkapre befriends a human, especially for love, the kapre will stick with its love interest\nfor the remainder of its life. Furthermore, if one is a buddy of the kapre, that person has the\npower to see it, and if they sit on it, anyone else may see it. This demonstrates that kapres are\na friendly species of humanoid.The kapre is said to house a mystical white stone the size of a\nquail egg in certain stories. The kapre has the ability to grant wishes to anyone who obtains this\nstone."
			}
		},
	7: {
		"name": "Sirena",
		"description" : "In Filipino mythology, the Sirena is a mythical sea creature. Sirenas are known as Magindara in\nvarious parts of the Philippines, particularly Bicol and Visayas, and are depicted as ferocious\nmermaids.",
		"icon":"res://ui/icons/creature icons/sirena-icon.png" ,
		"owned": false,
		"theme": "n/a",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image":"res://ui/icons/creature reward/sirena-reward.png" ,
			"video": "none",
			"info": "Sirenas are attractive marine creatures with a human-like upper body with long,flowing hair that\nis generally curly or wavy, and a fish-like lower body or tail. They were thoughtto be charming\nin pre-Hispanic Philippines.Sirena drowns fishermen and soldiers who worship Apo laki, accord-\ning to many Pangasinan mythology. They are said to be protectors of the waters of ''asin-palan,''\nprotecting it from tattooed Visayas raiders. Pre-colonial Filipinos thought that during the full\nmoon (or in the Dayaw or Kadayawan), Bulan, one of the moon's manifestations, descended from\nthe skies to swim with the mermaids, so the mermaids protected the boy moon from sea mon-\nsters. When a mermaid falls in love with a human, she or he becomes tame and submissive.\nThe Sirena is commonly accompanied by dugongs, sea turtles, and small cetaceans such as dol-\nphins. The Sirena has a lovely and seductive song that can captivate and attract males, especially\nfisherman. Sirena sing to sailors and enchant them, causing them to become distracted from\ntheir duties and walk off ship decks or cause shipwrecks. While hiding among the rocks near the\ncoast, they sing in lovely tones. The Sirena hypnotizes the guys and abducts them when they\nhear these tunes. According to legend, the Sirena take their victims under the sea and sacrifice\nthem to the water gods.  Other legends say that the Sirena act as drowning victims to lure men\ninto the sea, only to squeeze the life out of any man who falls victim to their trickery."
			}
		},
	8: {
		"name": "Engkanto",
		"description" : "Engakanto or Diwata also known in the Philippine mythology.\nEspecially in remote areas in the provinces.",
		"icon": "res://icon.png",
		"owned": false,
		"theme": "n/a",
		"price": 50,
		"fax": {#use "none" pag n/a
			"image": "none",
			"video": "none",
			"info": "Engkanto is divided into two genders. Engkantada is the female form of the engkanto. They are\ndescribed as a beautiful maiden with long golden hair, a slim, angelic face, and blue eyes, stand-\ning higher than the average woman. Engkanto males are known as Engkantado, and they are tall,\nwhite, and pale-skinned, and attractive. attractive. They are lost souls and others believed that\nthey were angels who disobeyed the word of God. They were kicked out from heaven and thrown\nto the land of mortals. Some fell in the river, woods, or trees. They might be playful at times, but\nif they despise you, they will make you sick. Modern medicine will not be able to help you. They\nmight be playful at times, but if they despise you, they will make you sick. Modern medicine will\nnot be able to help you. Engkanto do have capability to fall in love with mortals. But,you\nshould not accept him/her since they will take your soul if you do. Engkantada enjoys getting\ntogether with his friends. If you hear such voices in the woods, whether singing or laughing, it\nmeans they are having a party. It's also a good idea to ask permission to pass or just say''tabi\ntabi po, makikiraan po''. They may give you a reward if you treat them well. Some locals believed\nthat engkanto granted bountiful crops, a healthy body, and good fortune upon those who asked,\nin exchange for respect. "
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
