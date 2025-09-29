extends Node2D

func _ready():
	cabin.setup($Player, $Camera2D, $FadeScreen/ColorRect)
