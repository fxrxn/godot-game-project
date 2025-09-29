extends CharacterBody2D
@onready var latest_campfire: Node2D = null
@onready var tilemap_layer: TileMapLayer = get_node("../TileMapLayer")
@onready var player: CharacterBody2D = get_node(".")
@onready var animation_player: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var equipment_animations := [
	$boots,  # Boots
	$gloves, # Gloves
	$idols  # Amulet
]
@onready var footstep_timer = $FootstepTimer
@onready var footstep_sfx_nodes = [
	$FootstepSFX1,
	$FootstepSFX2,
	$FootstepSFX3,
]
var step_sounds: Array[AudioStream] = []
var current_step_node := 0

@onready var idle_animations = ["Idle_down", "Idle_left", "Idle_right", "Idle_up"]
@onready var match_manager: Node = get_node("/root/Main/Player/MatchManager")
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var raycast_up: RayCast2D = get_node("/root/Main/Player/RayCast2D_Up")
@onready var raycast_down: RayCast2D = get_node("/root/Main/Player/RayCast2D_Down")
@onready var raycast_left: RayCast2D = get_node("/root/Main/Player/RayCast2D_Left")
@onready var raycast_right: RayCast2D = get_node("/root/Main/Player/RayCast2D_Right")

@export var tile_size: Vector2
@export var current_direction: Vector2 = Vector2(0, -1)
@export var moving: bool = false
@export var target_position: Vector2
@export var move_duration: float = 1
@export var inv: Inv
@onready var idol = $Idol_Light
@onready var InvUI: = preload("res://inventory/inv_ui.gd")
@onready var spikes = false

var warm_boots_frames := preload("res://sprite_resources/warm_boots.tres")
var sturdy_boots_frames := preload("res://sprite_resources/sturdy_boots.tres")

# gloves
var warm_gloves_frames := preload("res://sprite_resources/warm_gloves.tres")
var sturdy_gloves_frames := preload("res://sprite_resources/sturdy_gloves.tres")

# amulets
var sun_amulet_frames := preload("res://sprite_resources/sun_idol.tres")
var moon_amulet_frames := preload("res://sprite_resources/moon_idol.tres")

func _ready() -> void:
	global.wearing_sun_idol = false
	global.wearing_moon_idol = false
	global.wearing_spiky_boots = false
	global.wearing_warm_boots = false
	global.wearing_warm_gloves = false
	global.wearing_sturdy_gloves = false
	update_equipment_visuals()
	tile_size = tilemap_layer.tile_set.get_tile_size()
	load_step_sounds()

func load_step_sounds():
	var dir = DirAccess.open("res://_soundsbaby/stepsounds/")  # Use your actual folder path
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".ogg"):
				var path = "res://_soundsbaby/stepsounds/" + file_name
				var stream = load(path)
				if stream is AudioStream:
					step_sounds.append(stream)
			file_name = dir.get_next()
		dir.list_dir_end()

	print("Loaded %s footstep sounds." % step_sounds.size())

func _process(_delta):
	if Input.is_action_just_pressed("print"):
		print("Player position: ", global_position)


func _input(event: InputEvent) -> void:
	if not warmth.alive:
		return
	if Input.is_action_pressed("look_modifier"):
		return
	if animation_player.is_playing() and not (animation_player.animation in idle_animations):
		return
	if event is InputEventKey and event.pressed and not moving:
		match event.keycode:
			KEY_W: move_player(Vector2(0, -1), raycast_up)
			KEY_S: move_player(Vector2(0, 1), raycast_down)
			KEY_A: move_player(Vector2(-1, 0), raycast_left)
			KEY_D: move_player(Vector2(1, 0), raycast_right)
			KEY_F: attempt_to_place_campfire()

func move_player(direction: Vector2, raycast: RayCast2D) -> void:
	raycast.force_raycast_update()
	if warmth.current_warmth <= 29:
		$Inv_Ui.shake_ui_by_warmth(warmth.current_warmth)
	if warmth.current_warmth < 1:
		Globald.show_dialogue("res://dialogues/step.dialogue","step_death")
		return
	if !raycast.is_colliding():
		if direction != current_direction:
			current_direction = direction
		target_position = position + direction * tile_size
		print("Before moving true")
		moving = true
		print("After moving true")
		footstep_timer.start()
		global.steps += 1
		if direction == Vector2(0,-1):
			global.goal += 1
			print(global.goal)
		
		if direction == Vector2(0,1):
			global.goal -= 1
			print(global.goal)
		
		print("Steps taken: ", global.steps)
		if global.star_steps and global.steps <= global.star_steps_count:
			footstep_timer.start()
			play_animation("Walk", direction)
			print("stepping starry")
			return
		if global.love and global.lovesteps_current > 0:
			global.lovesteps_current -= 1
			footstep_timer.start()
			play_animation("Walk", direction)
			print("stepping lovingly")
			return
		if global.summit_fever and  direction == Vector2(0,-1) and global.summit_fever_steps > 0:
			global.summit_fever_steps -= 1
			footstep_timer.start()
			play_animation("Walk", direction)
			print("stepping feverishly")
			return
			
		warmth.decrease_warmth(global.step_cost)
		if global.steps > 20 and global.wearing_moon_idol:
			idol.energy = 0
			var moon_chance = randf()
			if moon_chance >= 95:
				global.steps = 17
				idol.energy = 1.0
		if warmth.danger and global.step_luck > 3 and !spikes:
			var chance = randf()
			if chance > 0.50:
				$AnimatedSprite2D.stop()
				global.fallen = true
				dj.play_spooky()
				Globald.show_dialogue("res://dialogues/step.dialogue", "step_danger")
				global.step_luck = 0
				
			else:
				if global.step_luck >= 5 and !spikes:
					if chance > 0.10:
						$AnimatedSprite2D.stop()
						global.fallen = true
						dj.play_spooky()
						Globald.show_dialogue("res://dialogues/step.dialogue", "step_danger")
						global.step_luck = 0
		else:
			if warmth.danger and !spikes:
				var chance2 = randf()
				if chance2 > 0.10:
					global.step_luck += 1
		footstep_timer.start()
		play_animation("Walk", direction)
	else:
		if !global.fallen:
			play_animation("Idle", current_direction)
			moving = false
			footstep_timer.stop()
		else:
			return

	
func play_animation(state: String, direction: Vector2) -> void:
	if not warmth.alive:
		return
	var animation = state + "_" + get_direction_string(direction)
	animation_player.animation = animation
	dj.play_cloth_shuffle()
	animation_player.play()
	print("called for animation" + state)
	
	print("State: ", state, " | Direction: ", direction)

	
	for sprites in equipment_animations:
		if sprites.sprite_frames == null:
			print("checked for frames didn't find one")
			continue
		if sprites.sprite_frames.has_animation(animation):
			print("checked for frames foudn one")
			sprites.play(animation)

func _physics_process(_delta: float) -> void:
	if moving:
		# Move towards target position smoothly
		var move_step = (target_position - position).normalized() * (tile_size.length() / move_duration) * _delta
		position += move_step

		# If close enough to the target position, snap to grid
		if position.distance_to(target_position) < 0.25:
			position = target_position  # Snap exactly to target
			moving = false
			footstep_timer.stop()
			if not warmth.alive:
				return
			if !global.fallen:
				play_animation("Idle", current_direction)
			else:
				return

func attempt_to_place_campfire() -> void:
	if not warmth.alive:
		return
	if animation_player.is_playing() and not (animation_player.animation in idle_animations):
		print("cannot light a match playing an animation.")
		return
	else:
		print("no animation is playing lighting a match")
	if global.firekit >= 1 and global.current_matches >= 1:
		place_campfire_firekit()
		return
	if global.collected_wood >= 2 and global.current_matches >= 1:
		place_campfire()
	else:
		print("Not enough wood or matches to place a campfire.")

func place_campfire_firekit() -> void:
	var target_tile_position = position + current_direction * 16
		
	var raycast: RayCast2D = get_raycast_for_direction(current_direction)
	raycast.force_raycast_update()

	if !raycast.is_colliding():
		var campfire_scene = preload("res://scenes/firekit_campfire.tscn")
		var campfire = campfire_scene.instantiate()
		campfire.position = target_tile_position
		
		global.current_matches -= global.campfire_match_cost
		player.play_animation("Match" , player.current_direction)
		await animation_player.animation_finished
		get_tree().current_scene.add_child(campfire)
		global.campfire_number += 1
		global.firekit -= 1
		Globald.show_dialogue("res://dialogues/campfire.dialogue" , "firekit")
			
	else:
		print("Cannot place campfire, space ahead is blocked.")


func place_campfire() -> void:
	var target_tile_position = position + current_direction * 16
		
	var raycast: RayCast2D = get_raycast_for_direction(current_direction)
	raycast.force_raycast_update()

	if !raycast.is_colliding():
		var campfire_scene = preload("res://scenes/Campfire_scene.tscn")
		var campfire = campfire_scene.instantiate()
		campfire.position = target_tile_position
		global.collected_wood -= 2
		inv.remove(Itemdatabase.wood)
		inv.remove(Itemdatabase.wood)
		global.current_matches -= global.campfire_match_cost
		warmth.decrease_warmth(global.campfire_cost)
		player.play_animation("Match" , player.current_direction)
		await animation_player.animation_finished
		get_tree().current_scene.add_child(campfire)
		latest_campfire = campfire
		global.campfire_number += 1
			
	else:
		print("Cannot place campfire, space ahead is blocked.")

func get_raycast_for_direction(direction: Vector2) -> RayCast2D:
	match direction:
		Vector2(0, -1): return raycast_up
		Vector2(0, 1): return raycast_down
		Vector2(-1, 0): return raycast_left
		Vector2(1, 0): return raycast_right
	return raycast_up

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

func update_direction_to_wood(wood_position: Vector2) -> void:
	var direction_to_wood = (wood_position - position).normalized().round()
	
	if direction_to_wood == Vector2(0, -1):  
		print("Player will face Up")
		current_direction = Vector2(0, -1)
	elif direction_to_wood == Vector2(0, 1):  
		print("Player will face Down")
		current_direction = Vector2(0, 1)
	elif direction_to_wood == Vector2(-1, 0):  
		print("Player will face Left")
		current_direction = Vector2(-1, 0)
	elif direction_to_wood == Vector2(1, 0):  
		print("Player will face Right")
		current_direction = Vector2(1, 0)
	
	print("Current Direction Set to: ", current_direction)


# Function to play failed collect wood animation
func play_failed_collect_wood_animation(_wood_position: Vector2) -> void:
	if not warmth.alive:
		return
	player.play_animation("place_failed" , player.current_direction)

func collect(item):
	inv.insert(item)

func equip_boots(new_frames: SpriteFrames) -> void:
	$boots.sprite_frames = new_frames
	

func equip_gloves(new_frames: SpriteFrames) -> void:
	$gloves.sprite_frames = new_frames

func equip_amulet(new_frames: SpriteFrames) -> void:
	$idols.sprite_frames = new_frames

func update_equipment_visuals() -> void:
	if global.wearing_warm_boots:
		equip_boots(warm_boots_frames)
		global.love = true
		global.lovesteps_counter_max = 2
		global.star_steps = false
		print("wearing warm boots")
	elif global.wearing_spiky_boots:
		equip_boots(sturdy_boots_frames)
		spikes = true
		global.love = false
		print("wearing sturdy boots")
	else:
		$boots.sprite_frames = null  # Hide layer if nothing is equipped
		global.love = false
		global.star_steps = false
		global.star_steps_count = 0
	if global.wearing_warm_gloves:
		equip_gloves(warm_gloves_frames)
		global.loot_cost -= 1
		print("wearing warm gloves")
	elif global.wearing_sturdy_gloves:
		equip_gloves(sturdy_gloves_frames)
		global.max_wood += 2
		print("wearing sturdy gloves")
	else:
		$gloves.sprite_frames = null
		global.loot_cost = 5
		global.wood_cost = 3
		global.max_wood = 2

	if global.wearing_sun_idol:
		equip_amulet(sun_amulet_frames)
		idol.visible = true
		idol.color = Color(1.0, 0.9, 0.7)
		idol.energy = 0.6
		global.maxcampfire += 5
		print("wearing sun idol")
	elif global.wearing_moon_idol:
		equip_amulet(moon_amulet_frames)
		idol.visible = true
		idol.color = Color(0.6, 0.8, 1.0)
		idol.energy = 1.0
		global.star_steps = true
		global.star_steps_count = 20
		print("wearing moon idol")
	else:
		$idols.sprite_frames = null

func enter_door_and_teleport(target_position: Vector2) -> void:
	loot.unfreeze()
	var start_pos := position
	var end_pos := start_pos + Vector2(0, -1) * tile_size
	var halfway_time := move_duration / 2.0
	var tween := create_tween()

	current_direction = Vector2(0, -1)
	play_animation("Walk", current_direction)

	tween.tween_property(self, "position", end_pos, move_duration).set_trans(Tween.TRANS_LINEAR)
	await get_tree().create_timer(halfway_time).timeout

	cabin.fade_to_black()
	await get_tree().create_timer(move_duration - halfway_time).timeout

	position = end_pos

	position = target_position

	await cabin.wait_real_time(0.2)
	moving = false
	play_animation("Idle", current_direction)
	cabin.fade_from_black()
	get_tree().change_scene_to_file("res://demo folder/demo scenes/demo_gamewon.tscn")


func _on_footstep_timer_timeout() -> void:
	if step_sounds.is_empty():
		return

	var sfx = footstep_sfx_nodes[current_step_node]
	sfx.stream = step_sounds[randi() % step_sounds.size()]
	sfx.pitch_scale = 0.95 + randf() * 0.1  # optional variation
	sfx.play()

	current_step_node = (current_step_node + 1) % footstep_sfx_nodes.size()

func stop_footstep():
	footstep_timer.stop()

func skelly_death():
	current_direction = Vector2(-1,0)
	play_animation("trip", player.current_direction)
	await animation_player.animation_finished
	warmth.alive = false
	Globald.show_dialogue("res://dialogues/step.dialogue", "skelly_death")

func destroy_latest_campfire():
	latest_campfire.destroy_campfire()
