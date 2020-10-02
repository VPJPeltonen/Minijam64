extends Camera

export var camera_speed = 1.0

onready var target = get_parent().get_node("Cart/Visual/CameraTarget")
onready var cart = get_parent().get_node("Cart/Visual")

func _process(delta):
	global_transform.origin = global_transform.origin.linear_interpolate(target.global_transform.origin, camera_speed*delta)#target.global_transform.origin
	look_at(cart.global_transform.origin,Vector3.UP)
