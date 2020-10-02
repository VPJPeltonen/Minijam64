extends Control

func _ready():
	$GameView.show()
	$FinishScreen.hide()

func _on_Player_lap_passed(lap):
	$GameView/Lap/Amount.text = str(lap) + "/3"

func _on_Player_race_finished():
	$GameView.hide()
	$FinishScreen.show()
