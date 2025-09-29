extends Button

func _ready() -> void:
	print("Button is ready!")
	self.pressed.connect(_on_Button_pressed)
	dj.play_spooky_forest()



func _on_Button_pressed() -> void:
	dj.play_ui_chosing()
	dj.fade_out_spooky_forest()
	global.reset()
	dj.fade_in_ambiance_wind()
	get_tree().change_scene_to_file("res://scenes/maingo.tscn")  # Change to the main game scene


func _on_mouse_entered() -> void:
	dj.play_ui_mouse() 
