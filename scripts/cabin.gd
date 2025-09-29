extends Node

var player: Node2D
var camera: Camera2D
var fade_rect: ColorRect

# This is called once from your scene's _ready() to link references
func setup(player_node: Node2D, camera_node: Camera2D, fade_rect_node: ColorRect) -> void:
	player = player_node
	camera = camera_node
	fade_rect = fade_rect_node

# Call this to teleport player with a fade effect
func teleport_player_with_fade(target_position: Vector2, delay: float = 1.0) -> void:
	if not player or not camera or not fade_rect:
		push_error("TeleportManager not set up! Call setup() first.")
		return

	fade_to_black()
	await get_tree().create_timer(delay).timeout
	player.global_position = target_position
	camera.global_position = target_position
	await get_tree().create_timer(0.5).timeout
	fade_from_black()

# Fades the screen to black
func fade_to_black():
	fade_rect.visible = true
	fade_rect.color.a = 0.0
	fade_rect.create_tween().tween_property(fade_rect, "color:a", 1.0, 0.5)

# Fades the screen back to transparent
func fade_from_black():
	fade_rect.create_tween().tween_property(fade_rect, "color:a", 0.0, 0.5)

func fade_to_black_then_back(wait_time := 1.0) -> void:
	fade_to_black()
	await wait_real_time(0.5 + wait_time)  # Wait during fade & blackout
	fade_from_black()

func wait_real_time(seconds: float) -> void:
	var t := Timer.new()
	t.wait_time = seconds
	t.one_shot = true
	t.autostart = true
	t.process_mode = Node.PROCESS_MODE_ALWAYS  # ✅ Correct enum in Godot 4
	add_child(t)
	await t.timeout
	t.queue_free()
