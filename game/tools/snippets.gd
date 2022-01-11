extends Node
#Just some handy code snippets

onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var _music_files = [preload("res://environment/bgm/main.ogg"),preload("res://environment/bgm/main_loop.ogg") ]

#Get the world node
func get_world(world_name = "world") -> Node:
	return get_tree().root.get_node(world_name)

func _ready():
	music_player.pause_mode = 2
	music_player.connect("finished", self, "next_song")
	music_player.stream = _music_files[0]
	music_player.play()
	add_child(music_player)
	music_player.bus = "bgm"
	

func next_song():
	if g.in_game: return
	music_player.stream = _music_files[1]
	music_player.play()

func stop_main_theme():
	music_player.stop()
