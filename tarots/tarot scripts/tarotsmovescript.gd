extends Area2D

@onready var sprite = $Sprite2D  # Tarot card image
@onready var highlight = $Highlight  # Optional glow effect
@export var card_name : String = "fool_active"

var is_selected = false


func _ready():
	set_black_and_white()
	global.set(card_name, false)
	if highlight:
		highlight.visible = false  # Hide highlight at start


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()


		if (mouse_pos - global_position).length() <= 55:
			if is_selected:
				is_selected = false
				update_visuals()
				print("clicked tarot")
			else:
				if global.tarot_equipped >= global.max_tarot:
					print("max tarot")
					return
				else:
					is_selected = !is_selected  # Toggle selection
					update_visuals()
					print("Clicked on Tarot Card!")

func update_visuals():
	if is_selected:
		sprite.modulate = Color(1, 1, 1, 1)  # Full color
		global.tarot_equipped += 1  # Increment tarot count
		if highlight:
			highlight.visible = true  # Show highlight
		global.set(card_name, true)
		print(card_name)
	else:
		set_black_and_white()  # Revert to black and white
		global.tarot_equipped -= 1  # Decrease tarot count
		if highlight:
			highlight.visible = false  # Hide highlight
		global.set(card_name, false)

func set_black_and_white():
	sprite.modulate = Color(0.3, 0.3, 0.3, 1)  # Makes the card grayscale
