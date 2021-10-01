extends Node
#Just some handy code snippets

#Get the world node
func get_world(world_name = "world") -> Node:
	return get_tree().root.get_node(world_name)

