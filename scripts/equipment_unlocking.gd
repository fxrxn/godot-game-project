extends Area2D

@onready var inv_ui = get_node("/root/Main/Player/Inv_Ui")

func _on_body_entered(body: Node2D) -> void:
	inv_ui.open_upgrade()
