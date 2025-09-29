extends CharacterBody2D

@export var tile_size := Vector2(16, 16)  # Match your map’s tile size
@export var move_duration := 0.75  # Time to cross one tile
var target_position: Vector2
var moving := false
var steps_taken := 0
var max_steps := 3
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player := get_node("/root/Main/Player")  # Adjust path if different

func _ready():
	animation.play("idle")
	$PlayerHitbox.body_entered.connect(_on_player_hit)


func start_jump():
	animation.play("jump")
	print("skelly jumped")
	warmth.decrease_sanity(warmth.current_sanity)
	await animation.animation_finished
	start_walk()

func start_walk():
	animation.play("walk")
	calculate_next_target()

func calculate_next_target():
	if steps_taken >= max_steps:
		stop_and_disappear()
		return

	var direction = Vector2.LEFT  # Moving left only
	target_position = global_position + direction * tile_size
	moving = true

func _physics_process(delta):
	if moving:
		var step = (target_position - global_position).normalized() * (tile_size.length() / move_duration) * delta
		global_position += step

		if global_position.distance_to(target_position) < 0.25:
			global_position = target_position
			moving = false
			steps_taken += 1
			calculate_next_target()

func stop_and_disappear():
	moving = false
	animation.play("idle")
	print("Skeleton disappeared after ", steps_taken, " steps")
	await get_tree().create_timer(2.0).timeout
	warmth.increase_sanity(10)
	Globald.show_dialogue("res://dialogues/death.dialogue", "skelly")
	queue_free()  

func _on_player_hit(body):
	if body.name == "Player":
		print("skeleton touched")
		global_position = target_position
		moving = false
		animation.play("jump")
		player.skelly_death()
		await animation.animation_finished
		
