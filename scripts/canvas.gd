extends Node2D

tool

func _draw():
	var size = get_tree().root.size
	draw_rect(Rect2(Vector2(0, 0), size), Color.white)
	pass
