extends Button

func _ready() -> void:
	print("Button is ready!")
	self.pressed.connect(_on_Button_pressed)


func _on_Button_pressed() -> void:
	global.reset()
	global.intro_skip = true
	get_tree().change_scene_to_file("res://scenes/maingo.tscn")  # Change to the main game scene
