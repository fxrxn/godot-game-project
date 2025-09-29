extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slut: InvSlut):
	if !slut.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slut.item.texture
		item_visual.resize()
		if slut.amount > 1:
			amount_text.visible =true
		amount_text.text = str(slut.amount)
