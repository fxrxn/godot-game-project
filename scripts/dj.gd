extends Node

@onready var ambiance_wind = $ambiance_wind
@onready var ui_chosing = $ui_chosing
@onready var scary_ambient = $scary_ambient
@onready var crackling_wood = $crackling_wood
@onready var thud2 = $thud2
@onready var cloth_shuffle = $cloth_shuffle
@onready var spooky = $spooky
@onready var spooky2 = $spooky2
@onready var light_match = $light_match
@onready var ui_mouse = $ui_mouse
@onready var misty_step = $misty_step
@onready var sleddy = $sleddy
@onready var spookytension = $spookytension
@onready var thud = $thud
@onready var stronger_wind = $stronger_wind
@onready var spooky_forest = $spooky_forest

func play_ambiance_wind():
	ambiance_wind.play()

func play_ui_chosing():
	ui_chosing.play()

func play_scary_ambient():
	scary_ambient.play()

func play_crackling_wood():
	crackling_wood.play()

func play_thud2():
	thud2.play()

func play_cloth_shuffle():
	cloth_shuffle.play()

func play_spooky():
	spooky.play()

func play_spooky2():
	spooky2.play()

func play_light_match():
	light_match.play()

func play_ui_mouse():
	ui_mouse.play()

func play_misty_step():
	misty_step.play()

func play_sleddy():
	sleddy.play()

func play_spookytension():
	spookytension.play()

func play_thud():
	thud.play()

func play_stronger_wind():
	stronger_wind.play()

func play_spooky_forest():
	spooky_forest.play()

func fade_out_ambiance_wind(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(ambiance_wind, "volume_db", -80, duration)
	await tween.finished
	ambiance_wind.stop()

func fade_out_ui_chosing(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(ui_chosing, "volume_db", -80, duration)
	await tween.finished
	ui_chosing.stop()

func fade_out_scary_ambient(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(scary_ambient, "volume_db", -80, duration)
	await tween.finished
	scary_ambient.stop()

func fade_out_crackling_wood(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(crackling_wood, "volume_db", -80, duration)
	await tween.finished
	crackling_wood.stop()

func fade_out_thud2(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(thud2, "volume_db", -80, duration)
	await tween.finished
	thud2.stop()

func fade_out_cloth_shuffle(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(cloth_shuffle, "volume_db", -80, duration)
	await tween.finished
	cloth_shuffle.stop()

func fade_out_spooky(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(spooky, "volume_db", -80, duration)
	await tween.finished
	spooky.stop()

func fade_out_spooky2(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(spooky2, "volume_db", -80, duration)
	await tween.finished
	spooky2.stop()

func fade_out_match(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(light_match, "volume_db", -80, duration)
	await tween.finished
	light_match.stop()

func fade_out_ui_mouse(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(ui_mouse, "volume_db", -80, duration)
	await tween.finished
	ui_mouse.stop()

func fade_out_misty_step(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(misty_step, "volume_db", -80, duration)
	await tween.finished
	misty_step.stop()

func fade_out_sleddy(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(sleddy, "volume_db", -80, duration)
	await tween.finished
	sleddy.stop()

func fade_out_spookytension(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(spookytension, "volume_db", -80, duration)
	await tween.finished
	spookytension.stop()

func fade_out_thud(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(thud, "volume_db", -80, duration)
	await tween.finished
	thud.stop()

func fade_out_stronger_wind(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(stronger_wind, "volume_db", -80, duration)
	await tween.finished
	stronger_wind.stop()

func fade_out_spooky_forest(duration := 2.0):
	var tween = create_tween()
	tween.tween_property(spooky_forest, "volume_db", -80, duration)
	await tween.finished
	spooky_forest.stop()

func fade_in_ambiance_wind(duration := 2.0):
	ambiance_wind.volume_db = -80
	ambiance_wind.play()
	var tween = create_tween()
	tween.tween_property(ambiance_wind, "volume_db", 0, duration)

func fade_in_ui_chosing(duration := 2.0):
	ui_chosing.volume_db = -80
	ui_chosing.play()
	var tween = create_tween()
	tween.tween_property(ui_chosing, "volume_db", 0, duration)

func fade_in_scary_ambient(duration := 2.0):
	scary_ambient.volume_db = -80
	scary_ambient.play()
	var tween = create_tween()
	tween.tween_property(scary_ambient, "volume_db", 0, duration)

func fade_in_crackling_wood(duration := 2.0):
	crackling_wood.volume_db = -80
	crackling_wood.play()
	var tween = create_tween()
	tween.tween_property(crackling_wood, "volume_db", 0, duration)

func fade_in_thud2(duration := 2.0):
	thud2.volume_db = -80
	thud2.play()
	var tween = create_tween()
	tween.tween_property(thud2, "volume_db", 0, duration)

func fade_in_cloth_shuffle(duration := 2.0):
	cloth_shuffle.volume_db = -80
	cloth_shuffle.play()
	var tween = create_tween()
	tween.tween_property(cloth_shuffle, "volume_db", 0, duration)

func fade_in_spooky(duration := 2.0):
	spooky.volume_db = -80
	spooky.play()
	var tween = create_tween()
	tween.tween_property(spooky, "volume_db", 0, duration)

func fade_in_spooky2(duration := 2.0):
	spooky2.volume_db = -80
	spooky2.play()
	var tween = create_tween()
	tween.tween_property(spooky2, "volume_db", 0, duration)

func fade_in_match(duration := 2.0):
	light_match.volume_db = -80
	light_match.play()
	var tween = create_tween()
	tween.tween_property(light_match, "volume_db", 0, duration)

func fade_in_ui_mouse(duration := 2.0):
	ui_mouse.volume_db = -80
	ui_mouse.play()
	var tween = create_tween()
	tween.tween_property(ui_mouse, "volume_db", 0, duration)

func fade_in_misty_step(duration := 2.0):
	misty_step.volume_db = -80
	misty_step.play()
	var tween = create_tween()
	tween.tween_property(misty_step, "volume_db", 0, duration)

func fade_in_sleddy(duration := 2.0):
	sleddy.volume_db = -80
	sleddy.play()
	var tween = create_tween()
	tween.tween_property(sleddy, "volume_db", 0, duration)

func fade_in_spookytension(duration := 2.0):
	spookytension.volume_db = -80
	spookytension.play()
	var tween = create_tween()
	tween.tween_property(spookytension, "volume_db", 0, duration)

func fade_in_thud(duration := 2.0):
	thud.volume_db = -80
	thud.play()
	var tween = create_tween()
	tween.tween_property(thud, "volume_db", 0, duration)

func fade_in_stronger_wind(duration := 2.0):
	stronger_wind.volume_db = -80
	stronger_wind.play()
	var tween = create_tween()
	tween.tween_property(stronger_wind, "volume_db", 0, duration)

func fade_in_spooky_forest(duration := 2.0):
	spooky_forest.volume_db = -80
	spooky_forest.play()
	var tween = create_tween()
	tween.tween_property(spooky_forest, "volume_db", 0, duration)
