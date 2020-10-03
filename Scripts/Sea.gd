extends Area

func _on_Sea_body_entered(body):
	if body.is_in_group("Cart"):
		body.disable()
