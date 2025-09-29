extends Label

@onready var warmth: Node = get_node("/root/Main/campfire")  # Ensure the correct path to the campfire node
@export var tooltipstring: String = "The campfire will give {warmth_amount} warmth {max_campfire} amount of times."  # Placeholder text

# This function updates the tooltip text
func update_tooltip():
	if warmth != null:  # Check if the campfire node has the necessary method
		var warmth_amount = warmth.warmth_amount
		var max_campfire = warmth.maxcampfire
		var campfire_update = warmth.campfire_update
		
		# Replace placeholders in the tooltip_text with actual values
		var final_text = tooltipstring
		final_text = final_text.replace("{warmth_amount}", str(warmth_amount))
		final_text = final_text.replace("{max_campfire}", str(max_campfire))
		final_text = final_text.replace("{area_description}", ("in a larger area" if campfire_update else "in the immediate surroundings"))
		
		# Update the RichTextLabel's text (this will be visible in the game, but not in the Inspector)
		text = final_text

# This function is called every frame to update the tooltip
func _process(delta):
	update_tooltip()  # Continuously call the update_tooltip function during the game
