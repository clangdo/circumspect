extends Node2D

export var bot_start = Vector2(-20, 0)
export var top_start = Vector2(20, 0)
var blocked = true

var player

func _process(_delta):
	if not $assemble.is_stopped():
		var alpha = $assemble.time_left / $assemble.wait_time
		$top.position = alpha*top_start
		$bottom.position = alpha*bot_start
		modulate = Color(0, 0, 0, 1 - alpha)

	if not $slim.is_stopped():
		var beta = $slim.time_left / $slim.wait_time
		scale = Vector2(1, 0.5 + beta * 0.5)
		modulate = Color(0, 0, 0, 1)

	if not $decay.is_stopped():
		var cappa = $decay.time_left / $decay.wait_time
		if blocked:
			modulate = Color(0.2, 0.5, 1, cappa)
		else:
			modulate = Color(1, 0, 0, cappa)

func _on_assemble_timeout():
	$slim.start()


func _on_decay_timeout():
	queue_free()

func _on_slim_timeout():
	if is_instance_valid(player):
		blocked = not player.hit(rotation)
	$decay.start()
