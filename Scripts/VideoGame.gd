extends Spatial

func _on_UI_restart():
	get_parent().get_parent().restart_game()
