extends Panel

@onready var steps_label: Label = $StepsLabel
@onready var campfire_label: Label = $CampfireLabel
@onready var loot_label: Label = $LootLabel
@onready var death_label: Label = $DeathLabel
	
	

func _ready():
	steps_label.text = "Total steps taken this run: %d" % global.steps
	campfire_label.text = "Total campfires lit this run: %d" % global.campfire_number
	loot_label.text = "Total stuff interacted this run: %d" % global.loot_collected
	death_label.text = "Total amount of deaths overall: %d" % death.death_count
