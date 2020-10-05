extends Label

var stages = ["3","2","1","Go"]
var stage

onready var sound_player = $"../../SoundPlayer"

func start_countdown():
	$CountdownAnim.play("Countdown")
	stage = 0
	text = ""

func _on_Timer_timeout():
	if stage < 4:
		text = stages[stage]
		
	print(stage)
	if stage < 3:
		sound_player.play("CountdownTick")
	elif stage == 3:
		sound_player.play("CountdownDone")
		GAME.race_on = true
		get_parent().get_parent().race_time = 0.0
	elif stage > 3:
		hide()
		return
		
	stage += 1
		
	$Timer.start()
