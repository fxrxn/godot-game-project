extends StaticBody2D

@export var resource_name: String = "wood"
@onready var sprite = $AnimatedSprite2D
@onready var player = get_node("/root/Main/Player")  # Path to your player node
@onready var warmth_script = get_node("/root/Main/Player/Warmth")
@onready var raycast_up = get_node("/root/Main/Player/RayCast2D_Up")
@onready var raycast_down = get_node("/root/Main/Player/RayCast2D_Down")
@onready var raycast_left = get_node("/root/Main/Player/RayCast2D_Left")
@onready var raycast_right = get_node("/root/Main/Player/RayCast2D_Right")
@onready var animation_player = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var idle_animations = ["Idle_down", "Idle_left", "Idle_right", "Idle_up"]


func _ready():
	sprite.play(resource_name)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()
			if (mouse_pos - global_position).length() <= 10:
				if is_in_group("resource"):
					print(resource_name, " clicked at:", mouse_pos)
					collect_resource()
				else:
					print("Clicked object is not a resource.")
			else:
				print("Clicked outside of resource.")

func is_adjacent_to_resource(resource_pos: Vector2) -> bool:
	var raw_direction = resource_pos - player.global_position
	var dir_to_res = raw_direction.snapped(Vector2(1, 1)).normalized()

	if dir_to_res == Vector2(0, -1):
		if raycast_up.is_colliding():
			if raycast_up.get_collider().is_in_group("resource"):
				player.current_direction = Vector2(0, -1)
				return true

	if dir_to_res == Vector2(0, 1):
		if raycast_down.is_colliding():
			if raycast_down.get_collider().is_in_group("resource"):
				player.current_direction = Vector2(0, 1)
				return true

	if dir_to_res == Vector2(-1, 0):
		if raycast_left.is_colliding():
			if raycast_left.get_collider().is_in_group("resource"):
				player.current_direction = Vector2(-1, 0)
				return true

	if dir_to_res == Vector2(1, 0):
		if raycast_right.is_colliding():
			if raycast_right.get_collider().is_in_group("resource"):
				player.current_direction = Vector2(1, 0)
				return true

	return false

func collect_resource():
	if not warmth_script.alive:
		return

	if animation_player.is_playing() and not (animation_player.animation in idle_animations):
		print("Player busy")
		return

	if is_adjacent_to_resource(global_position):
		print("Player adjacent to ", resource_name)

		player.update_direction_to_wood(self.global_position)
		player.play_animation("Match", player.current_direction)
		await animation_player.animation_finished
		match resource_name:
			"wood":
				if global.fire and global.water and global.metal:
					Globald.show_dialogue("res://dialogues/taoism.dialogue", "wood")
					warmth.increase_sanity(50)
					if warmth.current_warmth < 20:
						warmth.increase_warmth(10)
					print("wood success")
				else:
					Globald.show_dialogue("res://dialogues/taoism.dialogue", "wood_fail")
					print("wood fail")

			"fire":
				print("Handle fire logic here")
				Globald.show_dialogue("res://dialogues/taoism.dialogue", "fire")
				global.fire = true

			"water":
				Globald.show_dialogue("res://dialogues/taoism.dialogue", "water")
				global.water = true
			"metal":
				Globald.show_dialogue("res://dialogues/taoism.dialogue", "metal")
				global.metal = true
	else:
		print("Player NOT adjacent to ", resource_name)
