extends Resource

class_name Inv

signal update 

@export var sluts: Array[InvSlut]

func insert(item:InvItem):
	print("called inventory script")
	var itemsluts = sluts.filter(func(slut):return slut.item == item)
	if !itemsluts.is_empty():
		itemsluts[0].amount += 1
	else:
		var emptysluts = sluts.filter(func(slut): return slut.item == null)
		if !emptysluts.is_empty():
			emptysluts[0].item = item
			emptysluts[0].amount =1
	update.emit()

func remove(item:InvItem):
	var itemsluts = sluts.filter(func(slut): return slut.item == item)
	if !itemsluts.is_empty():
		itemsluts[0].amount -= 1
		if itemsluts[0].amount <= 0:
			itemsluts[0].item = null
			itemsluts[0].amount = 0
		update.emit()
