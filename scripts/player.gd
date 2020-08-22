extends Node2D

export var health_proportion = 0.25
export var ring_proportion = 0.5
export var ring_width = 3.0
export var paddle_width = 10.0

export var paddle_angle = PI/12
export var max_health = 10

var pointer = Vector2(0, 0)
var angle = 0
var center = 0
var health = max_health

signal blocked
signal died

func _ready():
	_on_size_changed()
	var _error = get_tree().root.connect("size_changed", self, "_on_size_changed")

func _input(event):
	if event is InputEventMouse:
		pointer = event.position
		update()

func _process(_delta):
	angle = (pointer - center).angle()

func _draw():
	draw_health()
	draw_arc(center, min(center.x, center.y) * ring_proportion, 0, TAU, 100, Color.black, ring_width, false)
	draw_arc(center, min(center.x, center.y) * ring_proportion, angle - paddle_angle, angle + paddle_angle, 20, Color.black, paddle_width, false)

func draw_health():
	var health_ring_width = min(center.x, center.y) * health_proportion / max_health
	draw_circle(center, health_ring_width, Color.black)
	for i in range(1, health):
		draw_arc(center, health_ring_width * 0.5 + i * health_ring_width * 1.25, 0, TAU, 100, Color.black, health_ring_width, true)

func _on_size_changed():
	center = get_tree().root.size/2

func _in_range(x, range_low, range_high):
	return x < range_high and x > range_low

func dead():
	return health <= 0

func hit(hit_angle):
	var a1 = hit_angle - TAU
	var a2 = hit_angle
	var a3 = hit_angle + TAU
	var ccw = angle - paddle_angle
	var cw = angle + paddle_angle

	if not (_in_range(a1, ccw, cw) or _in_range(a2, ccw, cw) or _in_range(a3, ccw, cw)):
		if health == 1:
			emit_signal("died")
		health = max(health - 1, 0)
		update()
		return true
	emit_signal("blocked")
	return false
