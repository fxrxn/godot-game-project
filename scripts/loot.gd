extends Node
var matches_gained: int = 0
var wood_gained: int = 0
var last_gained: String = ""

var inv = preload("res://inventory/playersinventory.tres")

func found_matches() -> void:
	matches_gained += (randi() %3 + 1)
	global.current_matches += matches_gained
	last_gained = "You have found s%" % matches_gained + "matches"
	print (global.current_matches)
	print (matches_gained)

func found_wood() -> void:
	wood_gained += (randi() %global.max_wood + 1)
	global.collected_wood += wood_gained
	last_gained = "You have found s%" % wood_gained + "matches"
	print (global.collected_wood)
	print (wood_gained)
	
func found_empty() -> void:
	last_gained = "You couldn't find anything."
	print ('emptyy')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func unfreeze():
	get_tree().paused = false
	print("ended")
	
func freeze():
	var player = get_tree().current_scene.get_node("Player")
	var anim = player.get_node("AnimatedSprite2D")
	await anim.animation_finished
	get_tree().paused = true

func collect(item):
	inv.insert(item)
	print(item)
