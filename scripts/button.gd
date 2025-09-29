extends Button

func _on_pressed() -> void:
	print("Button was pressed!")
	global.tarot_equipped = 0
	print(global.tarot_equipped)
	global.tarot_check()
	get_tree().change_scene_to_file("res://scenes/maingo.tscn")  # Change to the main game scene
	
