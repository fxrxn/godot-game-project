extends Control

func _ready():
	#Reveal tips based on game state
	##get_node("Panel/TabContainer/Further Information").get_child(3).visible = global.tarots_unlocked
	#$Panel/TabContainer/Fire.get_child(1).visible = GameState.fire_unlocked
	print(",")


func _on_next_pressed() -> void:
	var tabs = $Panel/TabContainer
	tabs.current_tab = (tabs.current_tab + 1) % tabs.get_tab_count()

func _on_previous_pressed() -> void:
	var tabs = $Panel/TabContainer
	tabs.current_tab = (tabs.current_tab - 1 + tabs.get_tab_count()) % tabs.get_tab_count()
