extends Spatial

func _on_UI_restart():
	pass
	#get_parent().get_parent().restart_game()


func _on_RestartButton_pressed():
	get_parent().get_parent().restart_game()
