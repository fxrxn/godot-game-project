extends Button

func _ready() -> void:
	print("Button is ready!")
	self.pressed.connect(_on_Button_pressed)
	dj.fade_out_ambiance_wind()
	dj.fade_out_stronger_wind()


func _on_Button_pressed() -> void:
	dj.play_ui_chosing()
	dj.fade_in_spooky_forest()
	get_tree().change_scene_to_file("res://vertical slice/startingvertical.tscn")  # Change to the main game scene


func _on_mouse_entered() -> void:
	dj.play_ui_mouse() 
