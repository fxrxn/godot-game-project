extends Node2D

var wood_scene := preload("res://scenes/Wood.tscn")

func _ready():
	spawn_wood()
	queue_free()  

func spawn_wood():
	print("called spawn wood
	")
	var wood = wood_scene.instantiate()
	wood.position = position  
	get_parent().add_child.call_deferred(wood)
