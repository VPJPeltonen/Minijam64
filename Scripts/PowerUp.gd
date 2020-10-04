extends Area

var active = true
var power_ups = ["boost","nuke","missile","flame"]
var powerup = "boost"
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	powerup = power_ups[rng.randi_range(0,power_ups.size()-1)]
	$Itembox/AnimationPlayer.play("Cube021Action")

func _on_Timer_timeout():
	powerup = power_ups[rng.randi_range(0,power_ups.size()-1)]
	active = true
	$Itembox.show()

func _on_PowerUp_body_entered(body):
	if body.is_in_group("Cart") and active and body.power_up == null:
		body.GainPowerUp(powerup)
		$Itembox.hide()
		active = false
		$Timer.start()
