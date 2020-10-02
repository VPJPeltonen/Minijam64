extends Spatial

var turn_speed = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left"):
		rotate_y(delta*turn_speed)
	if Input.is_action_pressed("right"):
		rotate_y(-delta*turn_speed)
	transform.origin = get_parent().get_node("Cart").transform.origin
	
