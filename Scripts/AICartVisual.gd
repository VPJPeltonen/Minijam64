extends Spatial

var path
var turn_speed = 2.0
var drifting = false

onready var cart = get_parent().get_node("Cart")

func _process(delta):
	if !GAME.race_on:
		return
	look_at(path.path_nodes[cart.current_path_node].global_transform.origin,Vector3.UP)
	transform.origin = get_parent().get_node("Cart").transform.origin
	#transform.rotation_degrees
