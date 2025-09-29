extends AnimatedSprite2D

func _ready() -> void:
	var total_frames = sprite_frames.get_frame_count("default")
	var random_frame = randi() % total_frames
	animation = "default"
	frame = random_frame
	print("played", random_frame)
