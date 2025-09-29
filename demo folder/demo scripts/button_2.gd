extends Button

func _ready() -> void:
	print("Button is ready!")
	self.pressed.connect(_on_Button_pressed)


func _on_Button_pressed() -> void:
	global.reset()
	get_tree().quit()
