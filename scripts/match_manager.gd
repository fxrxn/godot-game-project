extends Node

@onready var player: Node = get_node("/root/Main/Player")  # Reference to the Player node
@onready var player_animated_sprite: AnimatedSprite2D = player.get_node("AnimatedSprite2D")  # Get AnimatedSprite2D from Player
@onready var warmth = get_node("/root/Main/Player/Warmth")
@onready var idle_animations = ["Idle_down", "Idle_left", "Idle_right", "Idle_up"]
@onready var mlight = $MatchLight

func _ready():
	global.current_matches = 20  # Tracks the current number of matches

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("light_match"):
		print("got match input")
		print("Warmth instance id:", str(warmth.alive))
		if warmth.alive == false:
			print("you're dead" , warmth.alive)
			return
		if player_animated_sprite.is_playing() and not (player_animated_sprite.animation in idle_animations):
			print("cannot light a match playing an animation.")
			return
		else:
			print("no animation is playing lighting a match")
			dj.play_light_match()
		if warmth.current_warmth < 1:
			Globald.show_dialogue("res://dialogues/match_danger.dialogue", "death")
		else:
			print("called light match check")
			light_match_check()

func light_match_check() -> void:
	if global.current_matches > 0 and !global.match_held and !player.moving and !global.fallen:
		if warmth.danger:
			print(warmth.danger)
			var chance = randf()
			if chance < 0.75:
				print("showing danger dialogue")
				Globald.show_dialogue("res://dialogues/match_danger.dialogue", "match_danger")
			else:
				print("showing safe dialogue")
				Globald.show_dialogue("res://dialogues/match.dialogue", "match")
		else:
				print("showing safe dialogue")
				Globald.show_dialogue("res://dialogues/match.dialogue", "match")
	elif global.current_matches <= 0:
		print("No matches left!")
		Globald.show_dialogue("res://dialogues/match_outofmatches.dialogue", "match_empty")
	elif global.match_held:
		print("A match is already lit!")
		Globald.show_dialogue("res://dialogues/match_alreadylit.dialogue", "match_alreadylit")
	
func light_match() -> void:
	global.match_held = true  # Set match_held to true
	if player and player_animated_sprite:
		var current_direction: Vector2 = player.current_direction  # Get direction from Player script
		var direction_string: String = player.get_direction_string(current_direction)  # Convert direction to string
		var match_animation = "Match_" + direction_string  # Construct animation name

		# Play the match animation
		player_animated_sprite.play(match_animation)
		await player_animated_sprite.animation_finished
		mlight.visible = true
		var match_ui = get_tree().get_root().get_node("Main/Player/Inv_Ui/Match_Burn_UI")  # Adjust path
		match_ui.play_burn_animation()
		print("Playing match light animation: ", match_animation)

		# Increase warmth 

		global.current_matches -= 1
		print("Matches left: ", global.current_matches)
		await get_tree().create_timer(2.0).timeout
		warmth.increase_warmth(1) 
		await get_tree().create_timer(2.0).timeout
		warmth.increase_warmth(1) 
		await get_tree().create_timer(2.0).timeout
		warmth.increase_warmth(1) 
		await get_tree().create_timer(2.0).timeout
		warmth.increase_warmth(1) 
		global.match_held = false
		mlight.visible = false
		
		print("Match expired. match_held is now false.")
	else:
		print("Error: Player or AnimatedSprite2D is null!")
