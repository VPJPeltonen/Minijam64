extends Spatial

export(PackedScene) var video_game

var start_played = false
var showing = "normal"
var transitioning = false

onready var camera_animator = $TheRoom64/CameraHolder/AnimationPlayer
onready var n64_animator = $TheRoom64/N64/AnimationPlayer
onready var controller = $TheRoom64/controler/AnimationPlayer

func _input(ev):
	if transitioning:
		return
	if ev is InputEventKey and !start_played:
		n64_animator.play("CartridgeENTER")
		$Timer.start(2)
		$Control/Label.hide()
		start_played = true
	if ev is InputEventKey and showing == "controls":
		showing = "none"
		$Control/Back.hide()
		camera_animator.play_backwards("IdleToCONTROLS")
	if ev is InputEventKey and showing == "exit":
		showing = "none"
		$Control/Back.hide()
		camera_animator.play_backwards("IdleToEXIT")
	if ev is InputEventKey and showing == "credits":
		showing = "none"
		$Control/Back.hide()
		camera_animator.play_backwards("IdleToCREDITS")			
		
func restart_game():
	print("room restart")
	$Viewport/VideoGame.queue_free()
	var new_game = video_game.instance()
	$Viewport.add_child(new_game)
	new_game.global_transform.origin = $Viewport/Position3D.global_transform.origin

func show_controls():
	transitioning = true
	$TransitionTimer.start()
	camera_animator.play("IdleToCONTROLS")
	showing = "controls"
	$Control/Back.show()

func show_exit():
	transitioning = true
	$TransitionTimer.start()
	camera_animator.play("IdleToEXIT")
	showing = "exit"
	$Control/Back.show()
	
func show_credits():
	transitioning = true
	$TransitionTimer.start()
	camera_animator.play("IdleToCREDITS")
	showing = "credits"
	$Control/Back.show()
	
func _on_Timer_timeout():
	camera_animator.play("Camera Intro")
	controller.play("ControlerUP")
	GAME.game_on = true
<<<<<<< HEAD
=======

func _on_TransitionTimer_timeout():
	transitioning = false
>>>>>>> 962f385b18d4d91b15d816f69b0a3adb64849533
