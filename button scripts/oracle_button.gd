extends Button


func _on_pressed() -> void:
	print("Button was pressed!")
	print(exp.exp)
	if exp.total_unlocked_cards == 22:
		get_tree().change_scene_to_file("res://scenes/starting_scene.tscn")
	else:
		exp.oracle()
