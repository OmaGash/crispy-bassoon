extends Control

var selection = 0 #0 for passive, 1 for active
enum{
	PASSIVE,
	ACTIVE
}

func _ready():
	if g.current_artifacts[0] == -1:
		$menu/VBoxContainer/panel/vbox/passive.icon = load("res://ui/artifax/none.png")
	else:
		$menu/VBoxContainer/panel/vbox/passive.icon = load("res://ui/artifax/passive" + str(g.current_artifacts[0]) + ".png")
	if g.current_artifacts[1] == -1:
		$menu/VBoxContainer/panel/vbox/active.icon = load("res://ui/artifax/none.png")
	else:
		$menu/VBoxContainer/panel/vbox/active.icon = load("res://ui/artifax/active" + str(g.current_artifacts[1]) + ".png")

func _on_passive_pressed():
	if g.artifact_passive == -1:#Dont show selection when thers no artifax unlocked yet
		var dialog = Button.new()
		dialog.text = "No artifacts unlocked"
		dialog.name = "error"
		$selector/a/b/panel/list.add_child(dialog)
		$selector.show()
		yield(dialog,"pressed")
		get_node("selector/a/b/panel/list/error").queue_free()
		$selector.hide()
		return
	for i in range(g.artifact_passive):
		var new_button: Button = Button.new()
		new_button.icon = load("res://ui/artifax/passive" + str(i) + ".png")
		new_button.name = str(i)
		selection = PASSIVE
		new_button.connect("pressed", self, "artifact_pressed", [new_button.name])
		$selector/a/b/panel/list.add_child(new_button)
	$selector.show()

func _on_active_pressed():
	if g.artifact_active == -1:
		var dialog = Button.new()
		dialog.text = "No artifacts unlocked"
		dialog.name = "error"
		$selector/a/b/panel/list.add_child(dialog)
		$selector.show()
		yield(dialog,"pressed")
		get_node("selector/a/b/panel/list/error").queue_free()
		$selector.hide()
		return
	for i in range(g.artifact_active):
		var new_button: Button = Button.new()
		new_button.icon = load("res://ui/artifax/active" + str(i) + ".png")
		new_button.name = str(i)
		selection = ACTIVE
		new_button.connect("pressed", self, "artifact_pressed", [new_button.name])
		$selector/a/b/panel/list.add_child(new_button)
	$selector.show()

func artifact_pressed(artifact: String):
	match selection:
		PASSIVE:
			g.current_artifacts[0] = int(artifact)
			$menu/VBoxContainer/panel/vbox/passive.icon = load("res://ui/artifax/passive" + artifact + ".png")
		ACTIVE:
			g.current_artifacts[1] = int(artifact)
			$menu/VBoxContainer/panel/vbox/active.icon = load("res://ui/artifax/active" + artifact + ".png")
	for node in $selector/a/b/panel/list.get_children():
		node.queue_free()
	$selector.hide()
