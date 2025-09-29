extends CanvasLayer

@onready var mat: ShaderMaterial = $ColorRect.material

var warmth := 1.0 # You can link this to your warmth manager later

func _process(_delta):
	var radius = lerp(0.4, 0.1, 1.0 - warmth)
	var alpha = lerp(0.0, 0.6, 1.0 - warmth)

	mat.set_shader_parameter("radius", radius)
	mat.set_shader_parameter("overlay_alpha", alpha)
	mat.set_shader_parameter("player_uv", Vector2(0.5, 0.5)) # Fixed center for now
