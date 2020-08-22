extends ColorRect

var alpha = 1

func _process(delta):
	if get_parent().visible:
		alpha = max(alpha - delta, 0)
	color = Color(0, 0, 0, 1 - alpha)
