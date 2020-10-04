extends Area

export(PackedScene) var explosion

var speed = 20.0
var dir

func _process(delta):
	look_at(global_transform.origin-dir,Vector3.UP)
	global_transform.origin -= dir*delta*speed

func _on_Nuke_body_entered(body):
	if body.is_in_group("Player"):
		return
	var blast_area = explosion.instance()
	get_parent().add_child(blast_area)
	blast_area.global_transform = global_transform
	queue_free()
