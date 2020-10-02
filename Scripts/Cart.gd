extends RigidBody

var move_speed = 80.0
var break_speed = 1.0

onready var target = get_parent().get_node("Visual/Target")

var on_road = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = global_transform.origin - target.global_transform.origin
	if Input.is_action_pressed("accelerate"):
		if on_road:
			add_central_force(dir * (-delta*move_speed))
		else: 
			add_central_force(dir * (-delta*move_speed*0.5))

func _on_Wheels_body_entered(body):
	if body.is_in_group("Road"):
		on_road = true
		print("track")

func _on_Wheels_body_exited(body):
	if body.is_in_group("Road"):
		on_road = false
		print("no track")
