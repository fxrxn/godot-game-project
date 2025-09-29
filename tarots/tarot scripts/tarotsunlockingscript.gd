extends Area2D

@onready var sprite = $Sprite2D  # Tarot card image
@onready var highlight = $Highlight  # Optional glow effect
@onready var locked = $locked
@export var card_name : String = "fool_active"
@onready var collision_shape = $CollisionShape2D2

func _ready():
	update_collision_shape_to_sprite()

func update_collision_shape_to_sprite():
	var tex = sprite.texture
	if tex and collision_shape.shape is RectangleShape2D:
		var size = tex.get_size() * sprite.scale
		collision_shape.shape.size = size

var is_selected = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		if (mouse_pos - global_position).length() <= 2:
			exp.last_unlocked = (card_name)
			update_visuals()

			

func update_visuals():
	if card_name == "Death" and exp.total_unlocked_cards == 21:
		drawing_death()
			
	else:
		if card_name == "Death":
			print("Foolish! Pick another one")
		else:
			exp.draw_card -= 1
			global.tarot_cards[card_name] = true
			exp.total_unlocked_cards += 1
			remove_child(locked)
			get_tree().change_scene_to_file("res://scenes/tarot_unlocking.tscn") 


func drawing_death():
	exp.draw_card -= 1
	global.tarot_cards[card_name] = true
	exp.total_unlocked_cards += 1
	remove_child(locked)
	get_tree().change_scene_to_file("res://scenes/tarot_unlocking.tscn")  # Change to the main game scene
