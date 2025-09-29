extends Node

@export var current_warmth: int = 75
@export var current_sanity: int = 50
@onready var alive = true
@onready var danger = false
@onready var death_state = false
@onready var first_time = true
@onready var first_timeS = true


signal warmth_changed(new_warmth)
signal sanity_changed(new_sanity)


func decrease_warmth(amount: int) -> void:
	# Decrease warmth by the specified amount
	print("called")
	current_warmth -= amount
	emit_signal("warmth_changed", current_warmth)
	print("Warmth decreased by ", amount, ". Current warmth: ", current_warmth)
	if current_warmth <= 1: 
		death_state = true
		print("death state entered")
	if current_warmth <= 25 and !danger:
		danger = true
		var danger_sprite = get_node("/root/Main/Player/Inv_Ui")  # Adjust path accordingly
		danger_sprite.show_sprite()
		if first_time:
			Globald.show_dialogue("res://dialogues/danger.dialogue", "start")
			first_time = false
		else:
			Globald.show_dialogue("res://dialogues/danger.dialogue", "again")
		print("danger is true")

func increase_warmth(amount: int) -> void:
	# Decrease warmth by the specified amount
	current_warmth += amount
	print("Warmth increased by ", amount, ". Current warmth: ", current_warmth)
	emit_signal("warmth_changed", current_warmth)
	if current_warmth > 55 and danger:
		danger = false
		var danger_sprite = get_node("/root/Main/Player/Inv_Ui")
		danger_sprite.hide_sprite()
		Globald.show_dialogue("res://dialogues/danger.dialogue", "warmed")

func dying():
	var warmth_node = get_tree().get_root().get_node("Main/Player/Warmth")
	warmth_node.alive = false
	print("alive is false from the node", warmth.alive , alive)
func _on_timer_timeout():
	# Once the timer times out, change the scene to the pop-up screen
	print("Death timer timed out. Changing scene.")  # Debugging

	get_tree().change_scene_to_file("res://scenes/dead_lol.tscn")

func decrease_sanity(amount: int) -> void:
	print("called")
	current_sanity -= amount
	emit_signal("sanity_changed", current_sanity)
	print("sanity decreased by ", amount, ". Current sanity: ", current_sanity)
	if current_sanity < 30 and first_timeS and current_sanity > 0:
		Globald.show_dialogue("res://dialogues/danger.dialogue", "low_sanity")
		first_timeS = false

func increase_sanity(amount: int) -> void:
	current_sanity += amount
	print("sanity increased by ", amount, ". Current sanity: ", current_sanity)
	emit_signal("sanity_changed", current_sanity)


func get_direction_string(direction: Vector2) -> String:
	if direction == Vector2(0, -1):
		return "up"
	elif direction == Vector2(0, 1):
		return "down"
	elif direction == Vector2(-1, 0):
		return "left"
	elif direction == Vector2(1, 0):
		return "right"
	return "up"
