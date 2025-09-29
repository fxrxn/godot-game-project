extends Button



func _ready() -> void:
	print("Button is ready!")
	self.pressed.connect(_on_Button_pressed)


func _on_Button_pressed() -> void:
	print("Button was pressed!")
	get_tree().change_scene_to_file("res://scenes/maingo.tscn")  # Change to the main game scene
