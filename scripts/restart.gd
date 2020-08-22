extends Button

func _on_restart_pressed():
	var _err = get_tree().reload_current_scene()
