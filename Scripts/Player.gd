extends Spatial

signal lap_passed(lap)
signal race_finished

export var turn_speed = 2.0
export var move_speed = 80.0
export var break_speed = 1.0
export var racer_name = "Racer"
export var kart_type = "basic"

export(Resource) var coblin
export(Resource) var cucaracha
export(Resource) var silber
export(Resource) var bone
export(Resource) var chingo
export(Resource) var gek

var current_checkpoint = 0
var current_lap = 1

func _ready():
	set_stats()
	
func _process(delta):
	check_drift()

func check_drift():
	if Input.is_action_pressed("drift"):
		$Cart/Visual.turn_speed = turn_speed/2
		$Cart/Cart.linear_damp = 0.1
	else:
		$Cart/Visual.turn_speed = turn_speed
		$Cart/Cart.linear_damp = 2.0

func set_stats():
	$Cart/Cart.move_speed = move_speed
	$Cart/Cart.break_speed = break_speed
	$Cart/Visual.turn_speed = turn_speed
	$Cart/Cart.racer_name = racer_name
	$Cart/Cart.kart_type = kart_type
	
# checks if passed checkpoint is next one or last one in the map
func checkpoint_passed(num):
	if current_checkpoint == GAME.last_checkpoint and num == 0:
		current_checkpoint = 0
		lap_passed()
	elif num == current_checkpoint+1:
		current_checkpoint = num
	print(current_checkpoint)

#when lap is passed
func lap_passed():
	print("trying to finish")
	if current_lap == GAME.Laps:
		current_lap += 1
		finish_race()
	else:
		current_lap += 1
		emit_signal("lap_passed",current_lap)

func finish_race():
	emit_signal("race_finished")

func _on_StartButton_pressed():
	pass # Replace with function body.

func _on_UI_car_select(car):
	match car:
		"coblin":
			$Cart/Visual/AnimatedSprite3D.frames = coblin
		"cucaracha":
			$Cart/Visual/AnimatedSprite3D.frames = cucaracha
		"silber":
			$Cart/Visual/AnimatedSprite3D.frames = silber
		"bone":
			$Cart/Visual/AnimatedSprite3D.frames = bone
		"chingo":
			$Cart/Visual/AnimatedSprite3D.frames = chingo
		"gek":
			$Cart/Visual/AnimatedSprite3D.frames = gek
