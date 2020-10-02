extends RigidBody

var move_speed = 80.0
var break_speed = 1.0

onready var target = get_parent().get_node("Visual/Target")
onready var main = get_parent().get_parent()

var on_road = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !GAME.race_on:
		return
	var dir = global_transform.origin - target.global_transform.origin
	if Input.is_action_pressed("drift"):
		linear_damp = 0.1
	else:
		linear_damp = 2.0
	if Input.is_action_pressed("accelerate"):
		if on_road and !Input.is_action_pressed("drift"):
			add_central_force(dir * (-delta*move_speed))
		else: 
			add_central_force(dir * (-delta*move_speed*0.5))
	if Input.is_action_pressed("break") and on_road:
		add_central_force(dir * (delta*move_speed*0.25))

#just passes the function to main player script
func checkpoint_passed(num):
	main.checkpoint_passed(num)

#when wheels touch the road
func _on_Wheels_body_entered(body):
	if body.is_in_group("Road"):
		on_road = true
		print("track")

#when feels leave the road
func _on_Wheels_body_exited(body):
	if body.is_in_group("Road"):
		on_road = false
		print("no track")
