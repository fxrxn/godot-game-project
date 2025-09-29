extends Control


@onready var inv: Inv = preload("res://inventory/playersinventory.tres")
@onready var sluts: Array = $NinePatchRect/GridContainer.get_children()
@onready var warmth_bar = $WarmthBar 
@onready var sanity_bar = $SanityBar
@onready var danger: Sprite2D = $Sprite2D
@onready var matches_icon = $MatchesIcon
@onready var matches_label = $MatchesCountLabel
@onready var wood_icon = $WoodIcon
@onready var wood_label = $WoodCountLabel
@onready var firekit_icon = $FirekitIcon
@onready var firekit_label = $FirekitCountLabel
@onready var warm_gloves = $warm_gloves
@onready var sturdy_gloves = $sturdy_gloves
@onready var warm_boots = $warm_boots
@onready var spiky_boots = $spiky_boots
@onready var sun_idol = $sun_idol
@onready var moon_idol = $moon_idol
@onready var panel = $Panel2
@onready var warmth = get_node("/root/Main/Player/Warmth")
@export var shake_duration := 0.4
@export var shake_magnitude := 10.0
@export var shake_frequency := 25.0
var original_position : Vector2
var time_left := 5.0

func _ready():
	hide()
	warmth.connect("warmth_changed", Callable(self, "_on_warmth_changed"))
	warmth.connect("sanity_changed", Callable(self, "_on_sanity_changed"))
	inv.update.connect(update_sluts)
	update_sluts()
	open()
	warmth_bar.value = warmth.current_warmth
	firekit_icon.visible = false
	firekit_label.visible = false
	warm_gloves.visible = false
	sturdy_gloves.visible = false
	warm_boots.visible = false
	spiky_boots.visible = false
	sun_idol.visible = false
	moon_idol.visible = false
	update_ui()
	original_position = position

func update_ui():
	# Update matches count and icon normal color
	matches_label.text = str(global.current_matches)
	matches_icon.modulate = Color(1, 1, 1)  # full color

	# Update wood count and grey out if zero
	wood_label.text = str(global.collected_wood)
	if global.collected_wood <= 0:
		wood_icon.modulate = Color(0.5, 0.5, 0.5, 1)  # greyed out
	else:
		wood_icon.modulate = Color(1, 1, 1, 1)  # normal color

	# Firekit visibility and color logic
	if global.firekits_unlocked:
		firekit_icon.visible = true
		firekit_label.visible = true
		firekit_label.text = str(global.firekit)
		if global.firekit <= 0:
			firekit_icon.modulate = Color(0.5, 0.5, 0.5, 1)
		else:
			firekit_icon.modulate = Color(1, 1, 1, 1)
	else:
		firekit_icon.visible = false
		firekit_label.visible = false
		
	if global.wearing_moon_idol:
		moon_idol.visible = true
	else:
		moon_idol.visible = false
	if global.wearing_warm_boots:
		warm_boots.visible = true
	else:
		warm_boots.visible = false

	if global.wearing_spiky_boots:
		spiky_boots.visible = true
	else:
		spiky_boots.visible = false

	if global.wearing_warm_gloves:
		warm_gloves.visible = true
	else:
		warm_gloves.visible = false

	if global.wearing_sturdy_gloves:
		sturdy_gloves.visible = true
	else:
		sturdy_gloves.visible = false

	if global.wearing_sun_idol:
		sun_idol.visible = true
	else:
		sun_idol.visible = false

	if global.wearing_moon_idol:
		moon_idol.visible = true
	else:
		moon_idol.visible = false


func refresh():
	update_ui()

func _process(delta):
	warmth_bar.value = warmth.current_warmth
	sanity_bar.value = warmth.current_sanity
	update_ui()
	if Input.is_action_pressed("look_modifier"):
		visible = false
	else:
		visible = true
		
func shake_ui_by_warmth(player_warmth: float):
	var max_magnitude = 10.0
	var clamped = clamp(player_warmth, 0.0, 30.0)
	var intensity = (1.0 - (clamped / 30.0)) * max_magnitude

	for child in get_children():
		if child.has_method("trigger_shake"):
			child.trigger_shake(intensity)

func show_sprite():
	danger.visible = true

func hide_sprite():
	danger.visible = false

var is_open = true

func update_sluts():
	for i in range(min(inv.sluts.size(), sluts.size())):
		sluts[i].update(inv.sluts[i])

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false


func _on_warmth_warmth_changed(value) -> void:
	warmth.current_warmth = clamp(value, 0, global.max_warmth)
	warmth_bar.value = warmth.current_warmth
	print("signal emitted " ,  warmth_bar.value)

func _unhandled_input(event):
	if event.is_action_pressed("ui"): 
		if get_tree().paused:
			get_tree().paused = false
			$Panel2.hide()
		else:
			get_tree().paused = true
			$Panel2.show()


func _on_button_pressed() -> void:
	dj.play_ui_chosing()
	get_tree().paused = false
	print("button pressed")
	panel.visible = false

func _on_button_2_pressed() -> void:
	print("controllls")
	dj.play_ui_chosing()


func _on_button_3_pressed() -> void:
	dj.play_ui_chosing()
	get_tree().paused = false
	print("button pressed")
	get_tree().change_scene_to_file("res://demo folder/demo scenes/DemoStarting.tscn")  


func _on_warmth_sanity_changed(value) -> void:
	warmth.current_sanity = clamp(value, 0, global.max_sanity)
	sanity_bar.value = warmth.current_sanity
	print("signal emitted for sanity" ,  sanity_bar.value)

func open_upgrade():
	$equipment_unlock.showtime()


func _on_button_mouse_entered() -> void:
	dj.play_ui_mouse()

func _on_button_2_mouse_entered() -> void:
	dj.play_ui_mouse()


func _on_button_3_mouse_entered() -> void:
	dj.play_ui_mouse()
