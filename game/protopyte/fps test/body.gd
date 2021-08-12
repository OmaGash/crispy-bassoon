extends Label

var count = 0 setget cound

func cound(new_value):
	count = new_value
	text = "Body count: " + str(count)

