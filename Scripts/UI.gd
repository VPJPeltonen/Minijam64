extends Control

signal restart
signal car_select(car)

export(Texture) var nuke
export(Texture) var boost
export(Texture) var flame
export(Texture) var missile

export(Texture) var coblin_view
export(Texture) var cucaracha_view
export(Texture) var silber_view
export(Texture) var bone_view
export(Texture) var chingo_view
export(Texture) var gek_view

var race_time = 0.0
var game_UI_mode = "start"
onready var racers = get_tree().get_nodes_in_group("Cart")

onready var start_menu_buttons = [$Start/BoxContainer/StartButton,$Start/BoxContainer/ControlsButton,$Start/BoxContainer/CreditsButton,$Start/BoxContainer/ExitButton]
var start_menu_focus = 0

onready var char_menu_row1 = [$CharacterSelect/VBoxContainer/Select/Selections/Row1/CharSelect,$CharacterSelect/VBoxContainer/Select/Selections/Row1/CharSelect2,$CharacterSelect/VBoxContainer/Select/Selections/Row1/CharSelect3]
onready var char_menu_row2 = [$CharacterSelect/VBoxContainer/Select/Selections/Row2/CharSelect,$CharacterSelect/VBoxContainer/Select/Selections/Row2/CharSelect2,$CharacterSelect/VBoxContainer/Select/Selections/Row2/CharSelect3]
onready var char_menu_row3 = [$CharacterSelect/VBoxContainer/Select/Selections/Row3/CharSelect,$CharacterSelect/VBoxContainer/Select/Selections/Row3/CharSelect2,$CharacterSelect/VBoxContainer/Select/Selections/Row3/CharSelect3]
onready var char_menu = [char_menu_row1,char_menu_row2,char_menu_row3]
var char_menu_focus_row = 0
var char_menu_focus_line = 0
var stored_racers = ["coblin","cucaracha","silber","bone","chingo","gek","none","none","none"]

onready var music_player: MusicPlayer = $MusicPlayer

func _ready():
	$GameView.hide()
	$FinishScreen.hide()
	$Start.show()
	$CharacterSelect.hide()
	$Start/BoxContainer/StartButton.grab_focus()

func _process(delta):
	if !GAME.game_on:
		return
	if GAME.race_on:
		race_time += delta
		$GameView/Time/Amount.text = format_time(race_time)
		check_race_order()
	else:
		match game_UI_mode:
			"start":
				if Input.is_action_just_pressed("ui_accept"):
					if get_focus_owner() != null:
						get_focus_owner().emit_signal("pressed") 
				if Input.is_action_just_pressed("ui_down"):
					if get_focus_owner() != null:
						start_menu_focus += 1
						if start_menu_focus > start_menu_buttons.size()-1:
							start_menu_focus = 0
						start_menu_buttons[start_menu_focus].grab_focus()
				if Input.is_action_just_pressed("ui_up"):
					if get_focus_owner() != null:
						start_menu_focus -= 1
						if start_menu_focus < 0:
							start_menu_focus = start_menu_buttons.size()-1
						start_menu_buttons[start_menu_focus].grab_focus()
			"char select":
				if Input.is_action_just_pressed("ui_accept"):
					print("trying")
					select_character()
				if Input.is_action_just_pressed("ui_down"):
					if get_focus_owner() != null:
						char_menu_focus_row += 1
						if char_menu_focus_row > char_menu.size()-1:
							char_menu_focus_row = 0
						char_menu[char_menu_focus_row][char_menu_focus_line].grab_focus()
						update_char_window()
				if Input.is_action_just_pressed("ui_up"):
					if get_focus_owner() != null:
						char_menu_focus_row -= 1
						if char_menu_focus_row < 0:
							char_menu_focus_row = char_menu.size()-1
						char_menu[char_menu_focus_row][char_menu_focus_line].grab_focus()
						update_char_window()
				if Input.is_action_just_pressed("ui_right"):
					if get_focus_owner() != null:
						char_menu_focus_line += 1
						if char_menu_focus_line > char_menu_row1.size()-1:
							char_menu_focus_line = 0
						char_menu[char_menu_focus_row][char_menu_focus_line].grab_focus()
						update_char_window()
				if Input.is_action_just_pressed("ui_left"):
					if get_focus_owner() != null:
						char_menu_focus_line -= 1
						if char_menu_focus_line < 0:
							char_menu_focus_line = char_menu_row1.size()-1
						char_menu[char_menu_focus_row][char_menu_focus_line].grab_focus()
						update_char_window()

func update_char_window():
	var racer_num = char_menu_focus_row*3+char_menu_focus_line
	match racer_num:
		0:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = coblin_view
		1:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = cucaracha_view
		2:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = silber_view
		3:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = bone_view
		4:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = chingo_view			
		5:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = gek_view
		_:
			$CharacterSelect/VBoxContainer/Select/TextureRect/View.texture = null

func select_character():
	var racer_num = char_menu_focus_row*3+char_menu_focus_line
	if racer_num >= 6:
		return
	match racer_num:
		0:
			emit_signal("car_select","coblin")
		1:
			emit_signal("car_select","cucaracha")
		2:
			emit_signal("car_select","silber")
		3:
			emit_signal("car_select","bone")
		4:
			emit_signal("car_select","chingo")
		5:
			emit_signal("car_select","gek")
	print("gaming")
	start_game()
	
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

func start_game():
	# Start countdown; stop music for now
	music_player.stop()
	$GameView/Countdown.start_countdown()
	$GameView.show()
	$CharacterSelect.hide()
	$FinishScreen.hide()
	$Start.hide()
	
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
	$FinishScreen/RestartButton.grab_focus()
	$Start.hide()

func _on_StartButton_pressed():
	game_UI_mode = "char select"
	$CharacterSelect/VBoxContainer/Select/Selections/Row1/CharSelect.grab_focus()
	$GameView.hide()
	$CharacterSelect.show()
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
