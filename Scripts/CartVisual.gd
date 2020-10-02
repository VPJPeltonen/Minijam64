extends Spatial

var turn_speed = 2.0
var drifting = false

func _process(delta):
	if !GAME.race_on:
		return
	$AnimatedSprite3D.play("forward")
	if Input.get_joy_axis(0,0) >= 0.2 :
		rotate_y(delta*turn_speed*-Input.get_joy_axis(0,0))
		$AnimatedSprite3D.play("right")
	if Input.get_joy_axis(0,0) <= -0.2:
		rotate_y(delta*turn_speed*-Input.get_joy_axis(0,0))
		$AnimatedSprite3D.play("left")
	else:
		if Input.is_action_pressed("left"):
			rotate_y(delta*turn_speed)
			$AnimatedSprite3D.play("left")
		if Input.is_action_pressed("right"):
			rotate_y(-delta*turn_speed)
			$AnimatedSprite3D.play("right")
	transform.origin = get_parent().get_node("Cart").transform.origin

