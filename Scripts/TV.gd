extends Spatial

func _ready():
	# Clear the viewport.
	var viewport = get_parent().get_node("Viewport")
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)

	# Let two frames pass to make sure the vieport is captured.
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	#yield(VisualServer, "frame_post_draw")
	
	# Retrieve the texture and set it to the viewport quad.
	var texture = viewport.get_texture()#.get_data()
	#texture.flip_y()
	
	#var tex = ImageTexture.new()
	#tex.create_from_image(texture)
	#texture.convert(Image.FORMAT_RGBA8)
	
	$Screen.material_override.albedo_texture = texture
