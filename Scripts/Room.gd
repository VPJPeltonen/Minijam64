extends Spatial

onready var camera_animator = $TheRoom64/CameraHolder/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_animator.play("Camera Intro")

