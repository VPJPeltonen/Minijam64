extends Spatial

onready var room = get_parent().get_parent()

func _on_UI_restart():
	pass
	#get_parent().get_parent().restart_game()

func _on_RestartButton_pressed():
	room.restart_game()

func _on_ControlsButton_pressed():
	room.show_controls()

func _on_ExitButton_pressed():
	room.show_exit()

func _on_CreditsButton_pressed():
	room.show_credits()
