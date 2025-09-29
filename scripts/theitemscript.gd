extends StaticBody2D

@onready var player = get_node("/root/Main/Player")  # Path to your player node
@onready var warmth_script = get_node("/root/Main/Player/Warmth")
@onready var raycast_up = get_node("/root/Main/Player/RayCast2D_Up")
@onready var raycast_down = get_node("/root/Main/Player/RayCast2D_Down")
@onready var raycast_left = get_node("/root/Main/Player/RayCast2D_Left")
@onready var raycast_right = get_node("/root/Main/Player/RayCast2D_Right")
@onready var animation_player = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var idle_animations = ["Idle_down", "Idle_left", "Idle_right", "Idle_up"]
# Function to update and get the global position of the wood item
@export var item: InvItem
var sounds = [preload("res://_soundsbaby/woodsounds/wood-break-40011.ogg"),
preload("res://_soundsbaby/woodsounds/wood-break-40012.ogg"),
preload("res://_soundsbaby/woodsounds/wood-break-400131.ogg"),
preload("res://_soundsbaby/woodsounds/woodbreak2.wav"),
preload("res://_soundsbaby/woodsounds/woodbreak3.ogg"),
preload("res://_soundsbaby/woodsounds/wood_break_1.wav")]

func collect_wood() -> void:
	if !warmth_script.alive:
		return
	if animation_player.is_playing() and not (animation_player.animation in idle_animations):  # Check if the player is already collecting
		print("Player is already collecting wood!")
		return  
	else:
		if is_adjacent_to_wood(global_position):  # Pass the wood's global position
			print("Player is adjacent to wood!")
			if global.collected_wood < global.max_wood:
				
				print("Player can collect wood!")
				
				player.update_direction_to_wood(self.global_position)

				if warmth_script.current_warmth < global.wood_cost:
					player.play_animation ("Idle" , player.current_direction)
					Globald.show_dialogue("res://dialogues/wood.dialogue", "wood_fail")
					return
				player.play_animation("Match" , player.current_direction)
				$CollectSFX.stream = sounds[randi() % sounds.size()]
				$CollectSFX.play()
				if warmth_script.current_sanity < 20:
					var chance = randf()
					if chance > 0:
						Globald.show_dialogue("res://dialogues/wood.dialogue", "wood_insane")
						queue_free()
						return
				if warmth_script.danger:
					if global.first_wood:
						print(global.first_wood)
						global.first_wood = false
						print(global.first_wood)
						Globald.show_dialogue("res://dialogues/wood.dialogue", "wood_danger")
					else:
						if !global.first_wood and global.second_wood:
							print("danger wood is 1")
							global.second_wood = false
							Globald.show_dialogue("res://dialogues/wood.dialogue", "wood_danger2")
						else:
							print("no more dialogueeee")
				global.collected_wood += global.wood_amount
				warmth.decrease_warmth(global.wood_cost)
				player.collect(item)
				print("Wood Collected! Total: ", global.collected_wood)
				# Remove wood from scene
				await animation_player.animation_finished
				queue_free()
			else:
				print("Player has reached max wood!")
				player.update_direction_to_wood(self.global_position)
				player.play_failed_collect_wood_animation(self.global_position)
		else:
			print("Player is NOT adjacent to the wood!")
	

func is_adjacent_to_wood(wood_position: Vector2) -> Vector2:
	var raw_direction = wood_position - player.global_position  # Use global_position
	print("Raw direction to wood:", raw_direction)
	
	var direction_to_wood = raw_direction.snapped(Vector2(1, 1)).normalized()  # Snapping to 1 unit
	print("Rounded direction to wood:", direction_to_wood)

	# Debugging: Print the player's and wood's positions
	print("Player Position:", player.global_position)
	print("Wood Position:", wood_position)

	# Return the correct direction based on the raycast hit
	if direction_to_wood == Vector2(0, -1):  # Up
		print("Checking UP raycast")
		if raycast_up.is_colliding():
			var hit = raycast_up.get_collider()
			print("UP Raycast hit:", hit)
			if hit != null and hit.is_in_group("wood"):
				player.current_direction = Vector2(0, -1)
				return Vector2(0, -1)  # Up
				
	
	elif direction_to_wood == Vector2(0, 1):  # Down
		print("Checking DOWN raycast")
		if raycast_down.is_colliding():
			var hit = raycast_down.get_collider()
			print("DOWN Raycast hit:", hit)
			if hit != null and hit.is_in_group("wood"):
				player.current_direction = Vector2(0, 1)
				return Vector2(0, 1)  # Down
	
	elif direction_to_wood == Vector2(-1, 0):  # Left
		print("Checking LEFT raycast")
		if raycast_left.is_colliding():
			var hit = raycast_left.get_collider()
			print("LEFT Raycast hit:", hit)
			if hit != null and hit.is_in_group("wood"):
				player.current_direction = Vector2(-1, 0)
				return Vector2(-1, 0)  # Left
	
	elif direction_to_wood == Vector2(1, 0):  # Right
		print("Checking RIGHT raycast")
		if raycast_right.is_colliding():
			var hit = raycast_right.get_collider()
			print("RIGHT Raycast hit:", hit)
			if hit != null and hit.is_in_group("wood"):
				player.current_direction = Vector2(-1, -0)
				return Vector2(1, 0)  # Right
	
	print("No raycast detected a wood tile!")
	return Vector2.ZERO  # Return zero if no wood found in range

# Function to detect if the player clicked on this wood item
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()  # Get mouse position
			var _wood_rect = get_viewport_rect()  # Get the wood’s boundaries

			# Check if the mouse is inside the wood’s area
			if (mouse_pos - global_position).length() <= 10:  # Adjust 10 for precision
				if is_in_group("wood"):
					print("Wood clicked at:", mouse_pos)
					collect_wood()
				else:
					print("Clicked object is not in the wood group.")
			else:
				print("Clicked outside of wood.")
