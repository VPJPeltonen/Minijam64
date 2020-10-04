extends Area


var speed = 15.0
var dir = Vector3(0,0,0)

func _process(delta):
	look_at(global_transform.origin-dir,Vector3.UP)
	global_transform.origin -= dir*delta*speed

func _on_Missile_body_entered(body):
	if body.is_in_group("Player"):
		return
	if body.is_in_group("Cart"):
		body.disable()
	#queue_free()
