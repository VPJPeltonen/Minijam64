extends "res://Scripts/Player.gd"

func _ready():
	set_stats()
	$Cart/Visual.path = get_parent().get_node("Path")
	$Cart/Cart.path = get_parent().get_node("Path")

# checks if passed checkpoint is next one or last one in the map
func checkpoint_passed(num):
	#print(num)
	if current_checkpoint == GAME.last_checkpoint and num == 0:
		current_checkpoint = 0
		lap_passed()
	elif num == current_checkpoint+1:
		current_checkpoint = num
		
func lap_passed():
	print("trying to finish")
	if current_lap == GAME.Laps:
		current_lap += 1
	else:
		current_lap += 1
		emit_signal("lap_passed",current_lap)
