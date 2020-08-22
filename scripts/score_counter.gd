extends Label

var game_p = NodePath("/root/game")
onready var game = get_node(game_p)

var score = 0

func _process(_delta):
	if is_instance_valid(game):
		score = game.score
	else:
		score = 0

	text = "Score: " + str(score)
	pass
