extends CanvasLayer

@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var aberration_mat = $ColorRect.material

func _process(delta):
	var current = warmth.current_sanity

	var trigger_threshold = 15.0
	var max_intensity = 5

	if current > trigger_threshold:
		aberration_mat.set_shader_parameter("intensity", 0.0)
		return

	var t = clamp((trigger_threshold - current) / trigger_threshold, 0.0, 1.0)
	aberration_mat.set_shader_parameter("intensity", t * max_intensity)
