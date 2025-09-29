extends CharacterBody2D

@onready var player = get_node("/root/Main/Player")
@onready var warmth_script = get_node("/root/Main/Player/Warmth")
@onready var inv_ui = get_node("/root/Main/Player/Inv_Ui")
@onready var raycast_up = get_node("/root/Main/Player/RayCast2D_Up")
@onready var raycast_down = get_node("/root/Main/Player/RayCast2D_Down")
@onready var raycast_left = get_node("/root/Main/Player/RayCast2D_Left")
@onready var raycast_right = get_node("/root/Main/Player/RayCast2D_Right")

# --- Your interaction ---
func _input(event: InputEvent) -> void:
	if !warmth_script.alive:
		return  # Don't allow if player is dead

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		if (mouse_pos - global_position).length() <= 10:  # click radius
			print("Clicked:", mouse_pos)
			if is_adjacent_to_object():
				print("Player is adjacent — running interaction")
				interact()
			else:
				print("Player NOT adjacent — no interaction")

# --- Your adjacent check ---
func is_adjacent_to_object() -> bool:
	var raw_direction = global_position - player.global_position
	var direction = raw_direction.snapped(Vector2(1, 1)).normalized()

	if direction == Vector2(0, -1) and raycast_up.is_colliding():
		var hit = raycast_up.get_collider()
		if hit == self:
			return true

	elif direction == Vector2(0, 1) and raycast_down.is_colliding():
		var hit = raycast_down.get_collider()
		if hit == self:
			return true

	elif direction == Vector2(-1, 0) and raycast_left.is_colliding():
		var hit = raycast_left.get_collider()
		if hit == self:
			return true

	elif direction == Vector2(1, 0) and raycast_right.is_colliding():
		var hit = raycast_right.get_collider()
		if hit == self:
			return true

	return false

# --- Your custom action ---
func interact():
	print("oracle clicked")
	Globald.show_dialogue("res://oracle.dialogue", "start")

func disappear():
	queue_free()
