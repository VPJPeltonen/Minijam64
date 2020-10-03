extends Label

var stages = ["3","2","1","Go"]
var stage

func start_countdown():
	$Timer.start()
	stage = 0
	text = stages[stage]

func _on_Timer_timeout():
	stage += 1
	if stage == 4:
		GAME.race_on = true
		get_parent().get_parent().race_time = 0.0
		hide()
		return
	text = stages[stage]
	$Timer.start()
