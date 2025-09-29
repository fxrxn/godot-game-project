extends StaticBody2D

@onready var player = get_node("/root/Main/Player")  # Path to your player node
@onready var raycast_up = get_node("/root/Main/Player/RayCast2D_Up")
@onready var raycast_down = get_node("/root/Main/Player/RayCast2D_Down")
@onready var raycast_left = get_node("/root/Main/Player/RayCast2D_Left")
@onready var raycast_right = get_node("/root/Main/Player/RayCast2D_Right")
@onready var animation_player = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var idle_animations = ["Idle_down", "Idle_left", "Idle_right", "Idle_up"]

func collect_loot() -> void:
	if not warmth.alive:
		return

	if animation_player.is_playing() and not (animation_player.animation in idle_animations):  # Check if the player is already collecting
		print("Player is already collecting loot!")
		return  
	else:
		if is_adjacent_to_loot(global_position):  # Pass the loot's global position
			print("Player is adjacent to loot!")
	
			print("Player can collect loot!")
			player.update_direction_to_wood(self.global_position)
			player.play_animation("Idle", player.current_direction)
			go_to_the_loot_screen()
			queue_free_after_unpause()
			print("loot Clicked!")
		else:
			print("Player is NOT adjacent to the loot!")
	
func queue_free_after_unpause() -> void:
	while get_tree().paused:
		await get_tree().process_frame  # Wait 1 frame
		await player.animation_player.animation_finished
	queue_free()

func is_adjacent_to_loot(loot_position: Vector2) -> Vector2:
	var raw_direction = loot_position - player.global_position  # Use global_position
	print("Raw direction to loot:", raw_direction)
	
	var direction_to_loot = raw_direction.snapped(Vector2(1, 1)).normalized()  # Snapping to 1 unit
	print("Rounded direction to loot:", direction_to_loot)

	# Debugging: Print the player's and loot's positions
	print("Player Position:", player.global_position)
	print("loot Position:", loot_position)

	# Return the correct direction based on the raycast hit
	if direction_to_loot == Vector2(0, -1):  # Up
		print("Checking UP raycast")
		if raycast_up.is_colliding():
			var hit = raycast_up.get_collider()
			print("UP Raycast hit:", hit)
			if hit != null and hit.is_in_group("loot"):
				player.current_direction = Vector2(0, -1)
				return Vector2(0, -1)  # Up
				
	
	elif direction_to_loot == Vector2(0, 1):  # Down
		print("Checking DOWN raycast")
		if raycast_down.is_colliding():
			var hit = raycast_down.get_collider()
			print("DOWN Raycast hit:", hit)
			if hit != null and hit.is_in_group("loot"):
				player.current_direction = Vector2(0, 1)
				return Vector2(0, 1)  # Down
	
	elif direction_to_loot == Vector2(-1, 0):  # Left
		print("Checking LEFT raycast")
		if raycast_left.is_colliding():
			var hit = raycast_left.get_collider()
			print("LEFT Raycast hit:", hit)
			if hit != null and hit.is_in_group("loot"):
				player.current_direction = Vector2(-1, 0)
				return Vector2(-1, 0)  # Left
	
	elif direction_to_loot == Vector2(1, 0):  # Right
		print("Checking RIGHT raycast")
		if raycast_right.is_colliding():
			var hit = raycast_right.get_collider()
			print("RIGHT Raycast hit:", hit)
			if hit != null and hit.is_in_group("loot"):
				player.current_direction = Vector2(-1, -0)
				return Vector2(1, 0)  # Right
	
	print("No raycast detected a loot tile!")
	return Vector2.ZERO  # Return zero if no loot found in range

# Function to detect if the player clicked on this loot item
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()  # Get mouse position
			var _loot_rect = get_viewport_rect()  # Get the loot’s boundaries

			# Check if the mouse is inside the loot’s area
			if (mouse_pos - global_position).length() <= 10:  # Adjust 10 for precision
				if is_in_group("loot"):
					print("loot clicked at:", mouse_pos)
					collect_loot()
				else:
					print("Clicked object is not in the loot group.")
			else:
				print("Clicked outside of loot.")


func go_to_the_loot_screen() -> void:
	# Check if all 4 items have already been found
	if global.found_warm_gloves and global.found_sturdy_gloves and global.found_warm_boots and global.found_spiky_boots:
		print("All equipment found.")
		Globald.show_dialogue("res://dialogues/equipment.dialogue", "all_equipment_found")
		return

	var available_items = []

	if !global.found_warm_gloves:
		available_items.append("warm_gloves")
	if !global.found_sturdy_gloves:
		available_items.append("sturdy_gloves")
	if !global.found_warm_boots:
		available_items.append("warm_boots")
	if !global.found_spiky_boots:
		available_items.append("spiky_boots")

	if available_items.is_empty():
		Globald.show_dialogue("res://dialogues/equipment.dialogue", "no_equipment_left")
		return

	var chosen = available_items[randi() % available_items.size()]
	print("Chosen loot item: ", chosen)

	match chosen:
		"warm_gloves":
			global.found_warm_gloves = true
			if global.wearing_sturdy_gloves:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "warm_gloves_conflict")
			else:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "warm_gloves")

		"sturdy_gloves":
			global.found_sturdy_gloves = true
			if global.wearing_warm_gloves:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "sturdy_gloves_conflict")
			else:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "sturdy_gloves")

		"warm_boots":
			global.found_warm_boots = true
			if global.wearing_spiky_boots:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "warm_boots_conflict")
			else:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "warm_boots")

		"spiky_boots":
			global.found_spiky_boots = true
			if global.wearing_warm_boots:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "spiky_boots_conflict")
			else:
				Globald.show_dialogue("res://dialogues/equipment.dialogue", "spiky_boots")
