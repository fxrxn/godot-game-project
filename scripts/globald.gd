extends Node
class_name DialogueUtils

var dialogue_manager_path := "res://addons/dialogue_manager/dialogue_manager.gd"
var in_dialogue = false
# Reuse a dictionary for preloaded dialogues if needed
var dialogue_cache := {}

func show_dialogue(dialogue_path: String, entry: String) -> void:
	if !dialogue_cache.has(dialogue_path):
		dialogue_cache[dialogue_path] = load(dialogue_path)

	var resource = dialogue_cache[dialogue_path]

	var dialog = DialogueManager.show_example_dialogue_balloon(resource, entry)
	DialogueManager.process_mode = Node.PROCESS_MODE_ALWAYS
	dialog.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	var in_dialogue = true
