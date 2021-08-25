extends Timer

var timer
var rng=RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rng.randi_range(3,5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
