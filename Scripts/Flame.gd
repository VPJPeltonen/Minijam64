extends Area

var burning = false

func activate_flame():
	burning = true
	$Flame.show()
	$Flame/CPUParticles.emitting = true
	$Flame/CPUParticles2.emitting = true
	$Flame/CPUParticles3.emitting = true
	$FlameTimer.start()

func _on_FlameTimer_timeout():
	$Flame.hide()
	$Flame/CPUParticles.emitting = false
	$Flame/CPUParticles2.emitting = false
	$Flame/CPUParticles3.emitting = false
	burning = false

func _on_Flame_body_entered(body):
	if body.is_in_group("Player"):
		return
	if body.is_in_group("Cart") and burning:
		body.disable()
