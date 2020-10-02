extends Control

func _on_Player_lap_passed(lap):
	$Lap/Amount.text = str(lap) + "/3"
