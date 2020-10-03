extends RigidBody

var move_speed = 80.0
var break_speed = 1.0
var forward_vector
var racer_name 
var kart_type
var last_checkpoint

onready var target = get_parent().get_node("Visual/Target")
onready var main = get_parent().get_parent()
onready var drift_effect1 = get_parent().get_node("Visual/DriftEffect")
onready var drift_effect2 = get_parent().get_node("Visual/DriftEffect2")

var on_road = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !GAME.race_on:
		return
	forward_vector = global_transform.origin - target.global_transform.origin
	check_drift()
	if Input.is_action_pressed("accelerate"):
		if on_road and !Input.is_action_pressed("drift"):
			add_central_force(forward_vector * (-delta*move_speed))
		else: 
			add_central_force(forward_vector * (-delta*move_speed*0.5))
	if Input.is_action_pressed("break") and on_road:
		add_central_force(forward_vector * (delta*move_speed*0.25))

func get_distance_raced():
	var lap_value = 1000.0
	var distance = main.current_lap*lap_value*2 + main.current_checkpoint * (lap_value/GAME.last_checkpoint)   
	if last_checkpoint != null:
		distance += global_transform.origin.distance_to(last_checkpoint.global_transform.origin)
	return distance

func set_sprite_view(view):
	get_parent().get_node("Visual/AnimatedSprite3D").play(view)

func check_drift():
	if Input.is_action_pressed("drift"):
		#linear_damp = 0.1
		drift_effect1.emitting = true
		drift_effect2.emitting = true
	else:
		#linear_damp = 2.0
		drift_effect1.emitting = false
		drift_effect2.emitting = false
		
func Boost(delta):
	add_central_force(forward_vector * (-delta*move_speed) * 2)

#just passes the function to main player script
func checkpoint_passed(num):
	main.checkpoint_passed(num)

#when wheels touch the road
func _on_Wheels_body_entered(body):
	if body.is_in_group("Road"):
		on_road = true

#when feels leave the road
func _on_Wheels_body_exited(body):
	if body.is_in_group("Road"):
		on_road = false
