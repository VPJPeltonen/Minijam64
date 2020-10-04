extends Area

var burning = false

func activate_flame():
	burning = true
	$MeshInstance.show()
	$FlameTimer.start()

func _on_FlameTimer_timeout():
	$MeshInstance.hide()
	burning = true

func _on_Flame_body_entered(body):
	if body.is_in_group("Cart") and burning:
		body.disable()
