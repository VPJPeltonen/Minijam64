extends Area

var size = Vector3(1.0,1.0,1.0)
var grow_speed = Vector3(1.0,1.0,1.0)

func _ready():
	$AnimatedSprite3D.play("default")

func _process(delta):
	size += grow_speed*delta*4
	$MeshInstance.scale = size
	$CollisionShape.scale = size

func _on_Timer_timeout():
	queue_free()

func _on_Explosion_body_entered(body):
	if body.is_in_group("Cart"):
		body.disable()

