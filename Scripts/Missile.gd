extends Area


var speed = 20.0
var dir = Vector3(0,0,0)
var target_racer

func _process(delta):
	look_at(target_racer.global_transform.origin,Vector3.UP)
	dir = global_transform.origin-target_racer.global_transform.origin
	dir = dir.normalized()
	global_transform.origin -= dir*delta*speed

func _on_Missile_body_entered(body):
	if body.is_in_group("Player"):
		return
	if body.is_in_group("Cart"):
		body.disable()
	queue_free()
