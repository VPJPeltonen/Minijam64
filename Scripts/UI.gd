extends Control

var race_time = 0.0
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
		#fix for ui controls not working on second screen, should find better way
		if Input.is_action_pressed("ui_accept"):
			GAME.race_on = true
			race_time = 0.0
			$GameView.show()
			$FinishScreen.hide()
			$Start.hide()
		
func check_race_order():
	var order = []
	for racer in racers:
		order.append([racer.racer_name,racer.get_distance_raced()])
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
	GAME.final_time = race_time
	$GameView.hide()
	$FinishScreen.show()
	$Start.hide()

func _on_StartButton_pressed():
	GAME.race_on = true
	race_time = 0.0
	$GameView.show()
	$FinishScreen.hide()
	$Start.hide()
