extends Spatial

export(PackedScene) var video_game

onready var camera_animator = $TheRoom64/CameraHolder/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_animator.play("Camera Intro")

func restart_game():
	print("room restart")
	$Viewport/VideoGame.queue_free()
	var new_game = video_game.instance()
	$Viewport.add_child(new_game)
	new_game.global_transform.origin = $Viewport/Position3D.global_transform.origin
