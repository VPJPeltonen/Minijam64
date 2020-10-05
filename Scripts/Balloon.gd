extends Spatial

var boostable = []
var boost_amount = 12000

func _process(delta):
	for cart in boostable:
		cart.add_central_force(Vector3.UP*delta*boost_amount)
		print("doing")

func _on_Balloon_body_entered(body):
	if body.is_in_group("Cart"):
		if !boostable.has(body):
			boostable.append(body)

func _on_Balloon_body_exited(body):
	if body.is_in_group("Cart"):
		if boostable.has(body):
			boostable.erase(body)

