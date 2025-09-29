extends AnimatedSprite2D

func _ready() -> void:
	visible = false
	
func play_burn_animation():
	visible = true
	frame = 0
	play("burn")  
	



func _on_animation_finished() -> void:
	visible = false
