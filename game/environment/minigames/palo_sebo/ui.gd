extends UI


func _ready():
	set_process(false)

func _process(delta):
	var time_left: String = "Time Left: %d"
	$info/time.text = time_left % [$"../time_limit".time_left]

func _on_start_pressed():
	get_tree().paused = false
	$"../time_limit".start()
	set_process(true)
	g.in_game = true
	$start_button.hide()


func _on_goal_body_entered(body):
	if not body.is_in_group("player"): return
	$"../time_limit".paused = true
	if $"../time_limit".time_left > 0:
		var pearls_won: int =  get_parent().difficulty * $"../time_limit".time_left
		toggle_menu(load("res://ui/post_results.tscn"))
		if has_node("submenu"):
			get_node("submenu").set_values("Victory!", "Palo sebo done in " + str(ceil($"../time_limit".wait_time - $"../time_limit".time_left)) + " seconds.", pearls_won)
