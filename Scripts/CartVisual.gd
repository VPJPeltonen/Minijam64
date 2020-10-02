extends Spatial

var turn_speed = 2.0

func _process(delta):
	if !GAME.race_on:
		return
	if Input.is_action_pressed("left"):
		rotate_y(delta*turn_speed)
	if Input.is_action_pressed("right"):
		rotate_y(-delta*turn_speed)
	transform.origin = get_parent().get_node("Cart").transform.origin
	
