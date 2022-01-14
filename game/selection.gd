extends Control

var current_selection: String setget _load_preview#Which game is selected
var current_page: String = "rules"#value is either rules or about
var info_src: = preload("res://ui/pre/pre_template.gd")#Use for reference
onready var info: PreMinigame = info_src.new()
onready var actual_content = $fax/contents/HBoxContainer/preview/preview_contents/actual_content/actual_actual_content

func _ready():
	theme = load(g.theme)
	$ScrollContainer.connect("game_selected", self, "_on_game_selected")

func _on_switch_pressed():
	match current_page:
		"rules":
			current_page = "about"
			_load_preview(current_selection)
			$fax/contents/HBoxContainer/buttons/switch.text = tr("tab_rules")
		"about":
			current_page = "rules"
			_load_preview(current_selection)
			$fax/contents/HBoxContainer/buttons/switch.text = tr("tab_about")


func _on_close_pressed():
	$anim.play_backwards("up")

func _on_game_selected(which_game: String):
	match which_game:
		"palo":
			self.current_selection = "palo"
		"sipa":
			self.current_selection = "sipa"
		"baka":
			self.current_selection = "baka"
		"langit":
			self.current_selection = "langit"

func _load_preview(game: String):#Load the contents of the preview
	current_selection = game
	if actual_content.get_child_count() > 0:#Remob ebriting
		for content in actual_content.get_children():
			content.queue_free()
	var text: Label = Label.new()
	text.text = (tr(info.data[game]["name"]) +
	"\n\n" + tr("tab_" + current_page)+ "\n\n"
	+ tr(info.data[game][current_page]))
	text.autowrap = true
	actual_content.add_child(text)
	print(text.text)



func _on_play_pressed():
	loader.load_scene(info.data[current_selection]["location"], gd.get_world("main_menu"))


func _on_back_pressed():
	$anim.play_backwards("fade")
	yield($anim, "animation_finished")
	queue_free()
