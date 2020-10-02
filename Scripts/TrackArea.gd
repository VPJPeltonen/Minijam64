extends Area

func _on_TrackArea_body_entered(body):
	if body.is_in_group("Cart"):
		body.on_road = true
		print("track")


func _on_TrackArea_body_exited(body):
	if body.is_in_group("Cart"):
		body.on_road = false
		print("off track")
