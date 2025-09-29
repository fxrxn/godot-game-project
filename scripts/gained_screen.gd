extends Node2D

@onready var label: Label = $Label


func _ready():
	label.text = "%s" % loot.last_gained 


func _on_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
