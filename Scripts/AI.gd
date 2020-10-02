extends "res://Scripts/Player.gd"

func _ready():
	set_stats()
	$Cart/Visual.path = get_parent().get_node("Path")
	$Cart/Cart.path = get_parent().get_node("Path")
