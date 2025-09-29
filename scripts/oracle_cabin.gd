extends CharacterBody2D

@onready var player = get_node("/root/Main/Player")  # Path to your player node
@onready var raycast_up = get_node("/root/Main/Player/RayCast2D_Up")
@onready var raycast_down = get_node("/root/Main/Player/RayCast2D_Down")
@onready var raycast_left = get_node("/root/Main/Player/RayCast2D_Left")
@onready var raycast_right = get_node("/root/Main/Player/RayCast2D_Right")
@onready var animation_player = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var idle_animations = ["Idle_down", "Idle_left", "Idle_right", "Idle_up"]

var resource= preload("res://dialogues/cabin_door.dialogue")
var dialogue_manager = ("res://addons/dialogue_manager/dialogue_manager.gd")

func enter_cabin() -> void:
	if not warmth.alive:
		return

	if animation_player.is_playing() and not (animation_player.animation in idle_animations):  # Check if the player is already collecting
		print("Player is already collecting busy!")
		return  # If true, exit early
	else:
		if is_adjacent_to_cabin(global_position):  # Pass the cabin_door's global position
			print("Player is adjacent to cabin_door!")
	
			print("Player can collect cabin_door!")
			player.update_direction_to_wood(self.global_position)
			go_to_the_cabin_door_screen()
			print("cabin_door Clicked!")
		else:
			print("Player is NOT adjacent to the cabin_door!")
	

func is_adjacent_to_cabin(cabin_door_position: Vector2) -> Vector2:
	var raw_direction = cabin_door_position - player.global_position  # Use global_position
	print("Raw direction to cabin_door:", raw_direction)
	
	var direction_to_cabin_door = raw_direction.snapped(Vector2(1, 1)).normalized()  # Snapping to 1 unit
	print("Rounded direction to cabin_door:", direction_to_cabin_door)

	# Debugging: Print the player's and cabin_door's positions
	print("Player Position:", player.global_position)
	print("cabin_door Position:", cabin_door_position)

	# Return the correct direction based on the raycast hit
	if direction_to_cabin_door == Vector2(0, -1):  # Up
		print("Checking UP raycast")
		if raycast_up.is_colliding():
			var hit = raycast_up.get_collider()
			print("UP Raycast hit:", hit)
			if hit != null and hit.is_in_group("cabin_door"):
				player.current_direction = Vector2(0, -1)
				return Vector2(0, -1)  # Up
				
	
	elif direction_to_cabin_door == Vector2(0, 1):  # Down
		print("Checking DOWN raycast")
		if raycast_down.is_colliding():
			var hit = raycast_down.get_collider()
			print("DOWN Raycast hit:", hit)
			if hit != null and hit.is_in_group("cabin_door"):
				player.current_direction = Vector2(0, 1)
				return Vector2(0, 1)  # Down
	
	elif direction_to_cabin_door == Vector2(-1, 0):  # Left
		print("Checking LEFT raycast")
		if raycast_left.is_colliding():
			var hit = raycast_left.get_collider()
			print("LEFT Raycast hit:", hit)
			if hit != null and hit.is_in_group("cabin_door"):
				player.current_direction = Vector2(-1, 0)
				return Vector2(-1, 0)  # Left
	
	elif direction_to_cabin_door == Vector2(1, 0):  # Right
		print("Checking RIGHT raycast")
		if raycast_right.is_colliding():
			var hit = raycast_right.get_collider()
			print("RIGHT Raycast hit:", hit)
			if hit != null and hit.is_in_group("cabin_door"):
				player.current_direction = Vector2(-1, -0)
				return Vector2(1, 0)  # Right
	
	print("No raycast detected a cabin_door tile!")
	return Vector2.ZERO  # Return zero if no cabin_door found in range

# Function to detect if the player clicked on this cabin_door item
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()  # Get mouse position
			var _cabin_door_rect = get_viewport_rect()  # Get the cabin_door’s boundaries

			# Check if the mouse is inside the cabin_door’s area
			if (mouse_pos - global_position).length() <= 10:  # Adjust 10 for precision
				if is_in_group("cabin_door"):
					print("cabin_door clicked at:", mouse_pos)
					enter_cabin()
				else:
					print("Clicked object is not in the cabin_door group.")
			else:
				print("Clicked outside of cabin_door.")

func go_to_the_cabin_door_screen() -> void:  # Pause the game while cabin_door screen is open
	DialogueManager.process_mode = Node.PROCESS_MODE_ALWAYS
	var dialog = DialogueManager.show_example_dialogue_balloon(resource, "cabin_door")
	dialog.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
