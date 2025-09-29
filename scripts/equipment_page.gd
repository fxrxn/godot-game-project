extends Control
@onready var sun_idol = $SunIdol
@onready var moon_idol = $MoonIdol
@onready var warm_gloves = $WarmGloves
@onready var sturdy_gloves = $SturdyGloves
@onready var warm_boots = $WarmBoots
@onready var spiky_boots = $SpikyBoots
@onready var player = get_node("/root/Main/Player")

func _ready() -> void:
	if global.unlocked_equipment:
		show()
		get_tree().paused = true
		sun_idol.visible = global.unlocked_sunidol
		moon_idol.visible = global.unlocked_moonidol
		warm_gloves.visible = global.unlocked_warm_gloves
		sturdy_gloves.visible = global.unlocked_sturdy_gloves
		warm_boots.visible = global.unlocked_warm_boots
		spiky_boots.visible = global.unlocked_spiky_boots
		
	
func _process(delta):
	$SunIdol/Highlight.visible = $SunIdol.button_pressed
	$MoonIdol/Highlight.visible = $MoonIdol.button_pressed
	$WarmGloves/Highlight.visible = $WarmGloves.button_pressed
	$SturdyGloves/Highlight.visible = $SturdyGloves.button_pressed
	$WarmBoots/Highlight.visible = $WarmBoots.button_pressed
	$SpikyBoots/Highlight.visible = $SpikyBoots.button_pressed


func _on_button_pressed() -> void:
	dj.play_ui_chosing()
	# Idols
	if $SunIdol.button_pressed:
		global.wearing_sun_idol = true
		global.wearing_moon_idol = false
	elif $MoonIdol.button_pressed:
		global.wearing_sun_idol = false
		global.wearing_moon_idol = true
	else:
		global.wearing_sun_idol = false
		global.wearing_moon_idol = false

	# Gloves
	if $WarmGloves.button_pressed:
		global.wearing_warm_gloves = true
		global.wearing_sturdy_gloves = false
	elif $SturdyGloves.button_pressed:
		global.wearing_warm_gloves = false
		global.wearing_sturdy_gloves = true
	else:
		global.wearing_warm_gloves = false
		global.wearing_sturdy_gloves = false

	# Boots
	if $WarmBoots.button_pressed:
		global.wearing_warm_boots = true
		global.wearing_spiky_boots = false
	elif $SpikyBoots.button_pressed:
		global.wearing_warm_boots = false
		global.wearing_spiky_boots = true
	else:
		global.wearing_warm_boots = false
		global.wearing_spiky_boots = false

	print("Equipped: ",
		" SunIdol:", global.wearing_sun_idol,
		" MoonIdol:", global.wearing_moon_idol,
		" WarmGloves:", global.wearing_warm_gloves,
		" SturdyGloves:", global.wearing_sturdy_gloves,
		" WarmBoots:", global.wearing_warm_boots,
		" SpikyBoots:", global.wearing_spiky_boots
	)
	hide()
	get_tree().paused = false
	player.update_equipment_visuals()


func _on_button_mouse_entered() -> void:
	dj.play_ui_mouse()
