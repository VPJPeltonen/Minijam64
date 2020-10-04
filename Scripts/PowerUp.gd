extends Area

var active = true
var powerup = "boost"

func _ready():
	$Itembox/AnimationPlayer.play("Cube021Action")

func _on_Timer_timeout():
	active = true
	$Itembox.show()

func _on_PowerUp_body_entered(body):
	if body.is_in_group("Cart") and active and body.power_up == null:
		body.GainPowerUp(powerup)
		$Itembox.hide()
		active = false
		$Timer.start()
