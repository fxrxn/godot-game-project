extends Control

var equipment_nodes = []
var equipment_flags = {}  # Pair nodes with their global flags
var containers = []

func showtime():
	show()
	equipment_nodes = [
		$SunIdol,
		$MoonIdol,
		$WarmGloves,
		$SturdyGloves,
		$WarmBoots,
		$SpikyBoots
	]

	equipment_flags = {
		$SunIdol: global.unlocked_sunidol,
		$MoonIdol: global.unlocked_moonidol,
		$WarmGloves: global.unlocked_warm_gloves,
		$SturdyGloves: global.unlocked_sturdy_gloves,
		$WarmBoots: global.unlocked_warm_boots,
		$SpikyBoots: global.unlocked_spiky_boots
	}

	containers = [
		$Container1,
		$Container2,
		$Container3
	]

	#Pick only *locked* equipment
	var available_nodes = []
	for node in equipment_nodes:
		if not equipment_flags[node]:
			available_nodes.append(node)

	#If none available, just close or do something else
	if available_nodes.is_empty():
		print("All equipment unlocked!")
		queue_free()
		return

	#Pick 3 or fewer unique
	var selected = []
	var available_copy = available_nodes.duplicate()
	while selected.size() < min(3, available_copy.size()):
		var pick = available_copy.pick_random()
		selected.append(pick)
		available_copy.erase(pick)

	#Hide all → show only selected
	for node in equipment_nodes:
		node.visible = false

	for i in selected.size():
		var node = selected[i]
		node.visible = true
		var offset = Vector2(-65, -150)  # left by 50, up by 30
		node.position = containers[i].position + offset


func _process(delta):
	$SunIdol/Highlight.visible = $SunIdol.button_pressed
	$MoonIdol/Highlight.visible = $MoonIdol.button_pressed
	$WarmGloves/Highlight.visible = $WarmGloves.button_pressed
	$SturdyGloves/Highlight.visible = $SturdyGloves.button_pressed
	$WarmBoots/Highlight.visible = $WarmBoots.button_pressed
	$SpikyBoots/Highlight.visible = $SpikyBoots.button_pressed

func _on_button_pressed() -> void:
	global.unlocked_equipment = true
	dj.play_ui_chosing()
	# Idols
	if $SunIdol.button_pressed:
		global.unlocked_sunidol = true
	elif $MoonIdol.button_pressed:
		global.unlocked_moonidol = true

	# Gloves
	if $WarmGloves.button_pressed:
		global.unlocked_warm_gloves = true
	elif $SturdyGloves.button_pressed:
		global.unlocked_sturdy_gloves = true

	# Boots
	if $WarmBoots.button_pressed:
		global.unlocked_warm_boots = true
	elif $SpikyBoots.button_pressed:
		global.unlocked_spiky_boots = true
	queue_free()
	get_tree().paused = false


func _on_button_mouse_entered() -> void:
	dj.play_ui_mouse() # Replace with function body.
