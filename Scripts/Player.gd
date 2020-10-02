extends Spatial

export var turn_speed = 2.0
export var move_speed = 80.0
export var break_speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Cart/Cart.move_speed = move_speed
	$Cart/Cart.break_speed = break_speed
	$Cart/Visual.turn_speed = turn_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
