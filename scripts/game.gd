extends Control

export var Needle:PackedScene

var screen_center = Vector2()
var game_over = false
var spawn_ready = false
var score = 0

func _ready():
	randomize()
	_on_viewport_resized()
	var _error = get_tree().root.connect("size_changed", self, "_on_viewport_resized")

func _on_viewport_resized():
	screen_center = get_tree().root.size/2

func _process(_delta):
	if spawn_ready and randi()%4 == 0:
		var inst = Needle.instance()
		var angle = (randf() - 0.5) * TAU
		var radius = min(screen_center.x, screen_center.y) * 3 / 4
		inst.position = screen_center + radius * Vector2(cos(angle), sin(angle))
		inst.rotation = angle
		inst.player = $player
		add_child_below_node($player, inst)
		$needle_spawn.start()
		spawn_ready = false

func _on_needle_spawn_timeout():
	if is_instance_valid(Needle) and not game_over:
		spawn_ready = true

func _on_player_died():
	game_over = true
	$game_over.show()


func _on_player_blocked():
	if not game_over:
		score += 1
