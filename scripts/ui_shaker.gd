extends Control

@export var shake_duration := 0.4
@export var shake_magnitude := 10.0
@export var shake_frequency := 30.0

var original_position : Vector2
var time_left := 0.0

func _ready():
	original_position = position

func _process(delta):
	if time_left > 0:
		time_left -= delta
		var shake_offset = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_magnitude * sin(time_left * shake_frequency)
		position = original_position + shake_offset
	else:
		position = original_position

func trigger_shake(custom_magnitude := -1.0):
	time_left = shake_duration
	if custom_magnitude >= 0.0:
		shake_magnitude = custom_magnitude
