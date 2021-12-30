extends Node
#This is for loading scenes(obviously)
#Usage:
#Add this code to where the scene switching takes place
#loader.load_scene(next_scene, self)

signal loading
signal done

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

var max_loading_time = 10000

func load_scene(path_to_scene: String, current_scene: Node):
	var loader = ResourceLoader.load_interactive(path_to_scene)
	if loader == null:
		var warning = load("res://ui/warning.tscn").instance()
		add_child(warning)
		warning.warn(get_tree(), "Resource loader returned null.")
		print("Error loading resource. (", path_to_scene, ") was not loaded")
		get_tree().quit()
		return
	
	var loading_bar: ProgressBar = load("res://ui/loading_bar.tscn").instance()
	var transition: ColorRect = load("res://ui/transition.tscn").instance()
	loading_bar.theme = load(g.theme) 
	transition.call_deferred("add_child", loading_bar)
	get_tree().root.call_deferred("add_child", transition)
	yield(transition.get_node("anim"), "animation_finished")
	var t = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() - t < max_loading_time:#Load while max_loading_time is not reached
		var err = loader.poll()
		if err == ERR_FILE_EOF:#Load done
			var resource: PackedScene = loader.get_resource()
			get_tree().root.call_deferred("add_child", resource.instance())
			loading_bar.queue_free()
			current_scene.queue_free()
			transition.get_node("anim").play_backwards("fade")
			yield(transition.get_node("anim"), "animation_finished")
			transition.queue_free()
			get_tree().root.set_disable_input(false)
			print("done")
			emit_signal("done")
			break
		elif err == OK:#Scene is loading
			emit_signal("loading")
			get_tree().root.set_disable_input(true)
			var progress = float(loader.get_stage())/loader.get_stage_count()
			loading_bar.value = progress * 100
		else:
			var warning = load("res://ui/warning.tscn").instance()
			add_child(warning)
			warning.warn(get_tree(), "Error loading scene [" + str(err) + "].")
			print("Error loading [", err, "].")
			break
		yield(get_tree(), "idle_frame")
