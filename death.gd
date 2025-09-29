extends Node

var death_count = 0
var resurrected = false
	
func die():
	var player = get_tree().get_root().get_node("Main/Player")
	var black = player.get_node("black")
	var warmth = player.get_node("Warmth")
	warmth.alive = false
	print("Warmth instance id:", str(warmth.alive))
	print("warmth.alive is" , warmth.alive)
	cabin.fade_to_black_then_back()
	await get_tree().create_timer(1.0).timeout
	var ui = player.get_node("Inv_Ui")
	ui.visible = false
	black.visible = true
	black = Control.MOUSE_FILTER_STOP

	if death_count >= 1 and !resurrected:
		print("resurrection scene")
		Globald.show_dialogue("res://dialogues/death.dialogue", "rez")
		resurrected = true
		return
	if death_count == 0 or resurrected:
		match death_count:
			0:
				print("zero death god im so stupid i started with one")
				death_count += 1
				resurrected = false
				Globald.show_dialogue("res://dialogues/death.dialogue", "zero")
			1:
				print("first death")
				death_count += 1
				resurrected = false
				Globald.show_dialogue("res://dialogues/death.dialogue", "first")
			2:
				print("second death")
				resurrected = false
				Globald.show_dialogue("res://dialogues/death.dialogue", "second")
				death_count += 1
			3: 
				print("third death")
				resurrected = false
				Globald.show_dialogue("res://dialogues/death.dialogue", "third")
				death_count += 1
			_:
				if death_count >= 4:
					print("fourth death")
					resurrected = false
					Globald.show_dialogue("res://dialogues/death.dialogue", "fourth")
					death_count += 1
				else:
					print("how tf did this happen")

func skelly_die():
	var player = get_tree().get_root().get_node("Main/Player")
	var black = player.get_node("black")
	var warmth = player.get_node("Warmth")
	warmth.alive = false
	print("Warmth instance id:", str(warmth.alive))
	print("warmth.alive is" , warmth.alive)
	cabin.fade_to_black_then_back()
	await get_tree().create_timer(1.0).timeout
	var ui = player.get_node("Inv_Ui")
	ui.visible = false
	black.visible = true
	black = Control.MOUSE_FILTER_STOP
	Globald.show_dialogue("res://dialogues/death.dialogue", "fourth")

func resurrect():
	resurrected = true
	print("rez function called")
	loot.unfreeze()
	var player = get_tree().get_root().get_node("Main/Player")
	var black = player.get_node("black")
	black.visible = false
	black = Control.MOUSE_FILTER_IGNORE
	var ui = player.get_node("Inv_Ui")
	ui.visible = true
	var warmth = player.get_node("Warmth")
	warmth.alive = true
	warmth.increase_warmth(60)

func backtomenu():
	loot.unfreeze()
	print("backtomenu called")
	await get_tree().create_timer(1.0).timeout
	print("change scene to file called")
	get_tree().change_scene_to_file("res://demo folder/demo scenes/DemoStarting.tscn")
