extends Area

var boostable = []

func _process(delta):
	for cart in boostable:
		cart.Boost(delta)

func _on_Boost_body_entered(body):
	if body.is_in_group("Cart"):
		if !boostable.has(body):
			boostable.append(body)

func _on_Boost_body_exited(body):
	if body.is_in_group("Cart"):
		if boostable.has(body):
			boostable.erase(body)
