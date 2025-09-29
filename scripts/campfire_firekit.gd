extends Node2D

@onready var warmth_timer: Timer = $Timer
@onready var player = get_node("/root/Main/Player")  # Reference to the player node
@export var campfire_scene: PackedScene  # Reference to the campfire scene
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var animation: AnimatedSprite2D = $StaticBody2D/AnimatedSprite2D
var warmth_given_count: int = 0  # Counter to track how many times warmth has been given
# Define the signal to send warmth
#ay yooo

func _ready() -> void:
	print("Campfire script initialized")
	animation.play("new_animation")
	# Ensure the timer is active and connects to the timeout signal
	warmth_timer.start()  # Start the timer
	warmth_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	print("Timer started.")
	var campfire_position = position
	
# Timer timeout callback function
func _on_Timer_timeout() -> void:
	print("Timer timeout triggered.")
	give_warmth()

# Called every time the warmth is triggered (when player is in range)
func give_warmth() -> void:
	# Debugging: Check if the warmth is being triggered
	print("Attempting to give warmth...")

	if is_player_in_range():
		print("Player is in range. Emitting warmth signal.")
		warmth.increase_warmth(1)  #global.warmth_amount    Emit the signal to increase warmth
		if global.temperance_active: 
			global.sanity += global.campfire_sanity
			print("Player received sanity: ", global.campfire_sanity, "Now total sanity: ", global.sanity)
		if global.love:
			global.lovesteps_current = global.lovesteps_counter_max
	else:
		print("Player is out of range. No warmth given.")
		
	# Increment the warmth count (attempt count) regardless of whether warmth is given
	warmth_given_count += 1
	print("Warmth given count: ", warmth_given_count)

	# If warmth has been attempted the specified number of times, destroy the campfire
	if warmth_given_count >= 15: #global.maxcampfire:
		print("Campfire has reached max warmth attempts. Destroying campfire.")
		destroy_campfire()  # Destroy the campfire node
	else:
		print("Campfire will attempt to provide warmth again.")

# Function to check if the player is adjacent to the campfire (including diagonals)
func is_player_in_range() -> bool:
	# Get the position of the campfire
	var campfire_position = position

	# Debugging: Print out the campfire position
	print("Campfire position: ", campfire_position)

	# Check the surrounding tiles based on the range
	var directions = [
		Vector2(-1, 0), Vector2(1, 0),  # Left, Right
		Vector2(0, -1), Vector2(0, 1),  # Up, Down
		Vector2(-1, -1), Vector2(1, -1),  # Top-left, Top-right
		Vector2(-1, 1), Vector2(1, 1)  # Bottom-left, Bottom-right
	]
	
	# Loop through all 8 directions and check if the player is in range
	for direction in directions:
		# Check if the player is within 1 tile distance of the campfire in this direction
		var check_position = campfire_position + direction * global.campfire_range
		print("Checking position: ", check_position)

		if check_position.distance_to(player.position) <= global.campfire_range:  # Check with the updated range
			print("Player is in range in direction: ", direction)
			return true

	# If no adjacency is found
	print("Player is not in range.")
	return false

func destroy_campfire():
	$StaticBody2D/CollisionShape2D2.disabled = true
	warmth_timer.queue_free()
	animation.play("burnt")
