extends Sprite2D

func resize():
	if texture:
		var texture_size = texture.get_size()
		var target_size = Vector2(18, 18)
		scale = target_size / texture_size  
