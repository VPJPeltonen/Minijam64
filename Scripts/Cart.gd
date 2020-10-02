extends RigidBody

var turn_speed = 20.0
var move_speed = 80.0
var break_speed = 1.0

onready var target = get_parent().get_node("Visual/Target")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_pressed("left"):
		#add_torque(Vector3(0,0,delta*turn_speed))
	#if Input.is_action_pressed("right"):
		#add_torque(Vector3(0,0,-delta*turn_speed))
	var dir = global_transform.origin - target.global_transform.origin
	if Input.is_action_pressed("accelerate"):
		add_central_force(dir * (-delta*move_speed))
	
