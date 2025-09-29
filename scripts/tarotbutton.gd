extends Button



func _ready() -> void:
	print("Button is ready!")
	self.pressed.connect(_on_Button_pressed)


func _on_Button_pressed() -> void:
	print(global.tarot_equipped)
	global.reset()
	if global.tarots_unlocked:
			get_tree().change_scene_to_file("res://scenes/tarotscene.tscn") 
			return
	
	get_tree().change_scene_to_file("res://scenes/maingo.tscn")  # Change to the main game scene
