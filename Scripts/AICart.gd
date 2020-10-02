extends RigidBody

var move_speed = 80.0
var break_speed = 1.0

var path
var current_path_node = 0

var on_road = true

onready var target = get_parent().get_node("Visual/Target")
onready var main = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !GAME.race_on:
		return
	var target_pos = path.path_nodes[current_path_node].global_transform.origin
	var dir = global_transform.origin - target_pos
	dir = dir.normalized()
	add_central_force(dir * (-delta*move_speed))
	if global_transform.origin.distance_to(target_pos) < 3.0:
		current_path_node += 1
		if current_path_node > path.path_nodes.size():
			current_path_node = 0

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