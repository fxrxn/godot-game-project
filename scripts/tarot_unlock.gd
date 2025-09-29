extends Control

@onready var label: Label = $Label


func _ready():
	update_tarot_screen()
	print("ready triggered")
	
	

func update_tarot_screen():
	label.text = "       Congratulations! You just unlocked: 
*                     The %s" % exp.last_unlocked + " card                  *"
