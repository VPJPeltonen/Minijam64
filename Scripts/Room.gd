extends Spatial

export(PackedScene) var video_game

var start_played = false

onready var camera_animator = $TheRoom64/CameraHolder/AnimationPlayer
onready var n64_animator = $TheRoom64/N64/AnimationPlayer
onready var controller = $TheRoom64/controler/AnimationPlayer

func _input(ev):
	if ev is InputEventKey and !start_played:
		n64_animator.play("CartridgeENTER")
		$Timer.start(2)	
		$Control/Label.hide()
		start_played = true

func restart_game():
	print("room restart")
	$Viewport/VideoGame.queue_free()
	var new_game = video_game.instance()
	$Viewport.add_child(new_game)
	new_game.global_transform.origin = $Viewport/Position3D.global_transform.origin

func _on_Timer_timeout():
	camera_animator.play("Camera Intro")
	controller.play("ControlerUP")
	GAME.game_on = true
