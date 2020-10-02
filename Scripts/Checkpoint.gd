extends Spatial

export var num = 0

func _on_Area_body_entered(body):
	if body.is_in_group("Cart"):
		body.checkpoint_passed(num)
