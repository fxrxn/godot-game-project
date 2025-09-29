extends Control

@onready var steps_label: Label = $StepsLabel
@onready var distance_label: Label = $DistanceLabel
@onready var campfire_label: Label = $CampfireLabel
@onready var loot_label: Label = $LootLabel
@onready var exp_label: Label = $ExpLabel
@onready var goal: int = 1600 - global.goal

func _ready():
	exp.gain_experience()
	update_death_screen()
	print("ready triggered")
	
	

func update_death_screen():
	steps_label.text = "Total Steps Taken: %d" % global.steps
	distance_label.text = "Distance Remaining: %d" % goal
	campfire_label.text = "Total Campfires Lit: %d" % global.campfire_number
	loot_label.text = "Total Stuff Interacted: %d" % global.loot_collected
	exp_label.text = "Total Experience Gained: %d" % exp.exp
	
