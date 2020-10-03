extends Control

signal restart

export(Texture) var nuke
export(Texture) var boost
export(Texture) var flame
export(Texture) var missile

var race_time = 0.0
var game_UI_mode = "start"
onready var racers = get_tree().get_nodes_in_group("Cart")

func _ready():
	$GameView.hide()
	$FinishScreen.hide()
	$Start.show()
	$Start/StartButton.grab_focus()

func _process(delta):
	if GAME.race_on:
		race_time += delta
		$GameView/Time/Amount.text = format_time(race_time)
		check_race_order()
	else:
		match game_UI_mode:
			"start":
				#fix for ui controls not working on second screen, should find better way
				if Input.is_action_pressed("ui_accept"):
					$GameView/Countdown.start_countdown()
					$GameView.show()
					$FinishScreen.hide()
					$Start.hide()
			"finished":
				if Input.is_action_pressed("ui_accept"):
					emit_signal("restart")
		
func check_race_order():
	var order = []
	for racer in racers:
		order.append([racer.racer_name,racer.get_distance_raced(),racer.kart_type])
	$GameView/RaceOrder.update_order(order)
		
func format_time(elapsed):
	var minutes = elapsed / 60.0
	var seconds = int(elapsed) % 60
	var milliseconds = (elapsed - int(elapsed))*1000 
	var str_elapsed = "%02d : %02d : %03d" % [minutes, seconds, milliseconds]
	return str_elapsed
	
func _on_Player_lap_passed(lap):
	$GameView/Lap/Amount.text = str(lap) + "/3"

func _on_Player_race_finished():
	game_UI_mode = "finished"
	GAME.final_time = race_time
	GAME.race_on = false
	$FinishScreen/Time/Amount.text = format_time(race_time)
	var order = []
	for racer in racers:
		order.append([racer.racer_name,racer.get_distance_raced(),racer.kart_type])
	$FinishScreen/FinishOrder.update_order(order)
	$GameView.hide()
	$FinishScreen.show()
	$Start.hide()

func _on_StartButton_pressed():
	GAME.race_on = true
	race_time = 0.0
	$GameView.show()
	$FinishScreen.hide()
	$Start.hide()

func _on_Cart_powerup_gained(power_up):
	$GameView/PowerUP.show()
	match power_up:
		"boost":
			$GameView/PowerUP.texture = boost
		"nuke":
			$GameView/PowerUP.texture = nuke
		"flame":
			$GameView/PowerUP.texture = flame
		"missile":
			$GameView/PowerUP.texture = missile

func _on_Cart_powerup_used():
	$GameView/PowerUP.hide()
