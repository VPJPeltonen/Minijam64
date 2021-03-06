extends RigidBody

var move_speed = 80.0
var break_speed = 1.0
var racer_name 
var kart_type
var last_checkpoint
var disabled = false
var power_up = null

var path
var current_path_node = 0
var forward_vector

var on_road = true

onready var target = get_parent().get_node("Visual/Target")
onready var main = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_pos = path.path_nodes[current_path_node].global_transform.origin
	forward_vector = global_transform.origin - target_pos	
	if !GAME.race_on or disabled:
		return
	var dir = forward_vector.normalized()
	add_central_force(dir * (-delta*move_speed))
	if global_transform.origin.distance_to(target_pos) < 3.0:
		current_path_node += 1
		if current_path_node > path.path_nodes.size()-1:
			current_path_node = 0
			
func GainPowerUp(powerup):
	power_up = powerup
	
func disable():
	disabled = true
	$SpawnTimer.start()

func get_distance_raced():
	var lap_value = 1000.0
	var distance = main.current_lap*lap_value*2 + main.current_checkpoint * (lap_value/GAME.last_checkpoint)   
	if last_checkpoint != null:
		distance += global_transform.origin.distance_to(last_checkpoint.global_transform.origin)
	return distance

func set_sprite_view(view):
	get_parent().get_node("Visual/AnimatedSprite3D").play(view)
	
func Boost(delta):
	var dir = global_transform.origin - target.global_transform.origin
	add_central_force(dir * (-delta*move_speed*2))
	
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

func _on_SpawnTimer_timeout():
	global_transform.origin = last_checkpoint.get_node("SpawnPoint").global_transform.origin
	disabled = false
