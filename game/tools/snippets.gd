extends Node
#Just some handy code snippets

var music_player:= AudioStreamPlayer.new()
var _music_files = ["res://environment/bgm/main.ogg","res://environment/bgm/main_loop.ogg" ]

#Get the world node
func get_world(world_name = "world") -> Node:
	return get_tree().root.get_node(world_name)

func _ready():
	music_player.pause_mode = 2
	var stream = AudioStream.new()
	music_player.connect("finished", self, "next_song")
	if File.new().file_exists(_music_files[0]):
		var music = load(_music_files[0])
		music_player.stream = music
		music_player.play()
	add_child(music_player)
	music_player.bus = "bgm"
	

func next_song():
	if g.in_game: return
	music_player.stream = load(_music_files[1])
	music_player.play()

func stop_main_theme():
	music_player.stop()
