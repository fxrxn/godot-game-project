extends LineEdit




func _on_button_pressed() -> void:
	if !global.player_name_given:
		var entered_name = self.text.strip_edges()
		global.player_name_given = true
		if entered_name != "":
			global.player_name = entered_name
			print("Player name set to: ", global.player_name)
		else:
			entered_name = "Karp"
			print("hihihi dev secret")
