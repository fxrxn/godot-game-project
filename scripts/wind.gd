extends Area2D
@onready var first_time = false

func _on_body_entered(body: Node2D) -> void:
	if !first_time:
		global.step_cost += 2
		global.wood_cost += 1
		global.loot_cost += 1
		Globald.show_dialogue("res://dialogues/wind.dialogue", "wind")
		dj.fade_out_ambiance_wind()
		dj.fade_in_stronger_wind()
		first_time = true
