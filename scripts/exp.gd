extends Node

var player_level: int = 0
var draw_card: int = 0
var exp: int = 99999999999999
var last_unlocked: String = "nothing"
var total_unlocked_cards: int = 0



func gain_experience():
	var exp_gain = (global.goal + (global.campfire_number + 5)  * (global.loot_collected + 1))
	print("gained experience", exp_gain)
	exp = exp + exp_gain
	
	
func check_level_up():
	print("Checked level up")
	while exp >= (320 * pow(2, player_level - 1)) and player_level < 23:
		player_level += 1
		draw_card += 1  
		exp -= 320 * pow(2, player_level - 1)  # Subtract the experience required for the current level
		print(exp)

func oracle():
	if draw_card > 0:
		get_tree().change_scene_to_file("res://scenes/oracle.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/starting_scene.tscn")  # Change to the main game scene
