extends Camera2D

@onready var player = get_node("/root/Main/Player")  # Adjust path if necessary
@onready var warmth = get_node("/root/Main/Player/Warmth")

var offset_x: float = 0  # To store the initial X position of the camera
var look_offset := Vector2.ZERO
var max_look_distance := 100  # how far up/down you can look
var look_speed := 5.0        # how quickly the camera moves to target offset
var normal_zoom = 6.5
var max_zoom = 8.0  
var start_zooming_at = 29.0
var intense_below = 5.0
	
func _ready() -> void:
	# Set the initial offset of the camera's X position to the player's X position
	offset_x = position.x

func _process(delta: float) -> void:
	# Lock the camera’s X position to follow the player’s starting X position
	# position.x = offset_x
	# Make the camera follow only the Y position of the player (up and down)
	position.y = player.position.y
	position.x = player.position.x
	# Reset offset
	var target_offset := Vector2.ZERO

	# If CTRL is held, check for up/down
	if Input.is_action_pressed("look_modifier"):
		if Input.is_action_pressed("look_up"):
			target_offset.y -= max_look_distance
		elif Input.is_action_pressed("look_down"):
			target_offset.y += max_look_distance

	# Smooth camera movement toward target offset
	look_offset = look_offset.lerp(target_offset, delta * look_speed)
	offset = look_offset
	
	var current = warmth.current_sanity

# If sanity is above 30, keep normal zoom
	if current >= 30:
		zoom = Vector2(normal_zoom, normal_zoom)
		return

	if current <= 0:
		zoom = Vector2(15.0, 15.0)
		return

# Otherwise, smoothly zoom based on sanity
	var t = clamp((start_zooming_at - current) / start_zooming_at, 0.0, 1.0)
	var zoom_val = lerp(normal_zoom, max_zoom, t)
	zoom = zoom.lerp(Vector2(zoom_val, zoom_val), 0.1)
