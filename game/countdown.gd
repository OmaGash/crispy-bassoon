extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var m 
var s 
func _ready():
	m = 1
	s =  0
func _process(delta):
	if s == 0 and m >= 1:
		s = 59
		m -= 1
	if m < 0:
		s -= 1
		m = 0
	
#	if m <= 0 and s < 0:
#		$Timer.stop()
	
	set_text("0" + str(m) + ":" + str(s))
	
	if s < 10:
		set_text("0" + str(m) + ":" + "0" + str(s))
	if m <= 0 and s <= 0:
		$Timer.stop()

func _on_Timer_timeout():

	s -= 1
	

