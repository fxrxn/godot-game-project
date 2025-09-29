extends Panel

var tarot_scenes = {
	"fool": preload("res://tarots/tarot scenes/fool.tscn"),
	"mage": preload("res://tarots/tarot scenes/mage.tscn"),
	"priestess": preload("res://tarots/tarot scenes/priestess.tscn"),
	"empress": preload("res://tarots/tarot scenes/empress.tscn"),
	"emperor": preload("res://tarots/tarot scenes/emperor.tscn"),
	"hierophant": preload("res://tarots/tarot scenes/hierophant.tscn"),
	"lovers": preload("res://tarots/tarot scenes/lovers.tscn"),
	"chariot": preload("res://tarots/tarot scenes/chariot.tscn"),
	"strength": preload("res://tarots/tarot scenes/strength.tscn"),
	"hermit": preload("res://tarots/tarot scenes/hermit.tscn"),
	"fortune": preload("res://tarots/tarot scenes/fortune.tscn"),
	"justice": preload("res://tarots/tarot scenes/justice.tscn"),
	"hangedman": preload("res://tarots/tarot scenes/hangedman.tscn"),
	"death": preload("res://tarots/tarot scenes/death.tscn"),
	"temperance": preload("res://tarots/tarot scenes/temperance.tscn"),
	"devil": preload("res://tarots/tarot scenes/devil.tscn"),
	"tower": preload("res://tarots/tarot scenes/tower.tscn"),
	"star": preload("res://tarots/tarot scenes/star.tscn"),
	"moon": preload("res://tarots/tarot scenes/moon.tscn"),
	"sun": preload("res://tarots/tarot scenes/sun.tscn"),
	"judgement": preload("res://tarots/tarot scenes/judgement.tscn"),
	"world": preload("res://tarots/tarot scenes/world.tscn"),
	"empty": preload("res://tarots/tarot scenes/empty.tscn"),
	"death_empty": preload("res://tarots/tarot scenes/empty_death.tscn"),
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.tarot_cards["Fool"]:
		var fool = tarot_scenes["fool"].instantiate()
		add_child(fool)
		fool.position = Vector2(150, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(150, 350)
	if global.tarot_cards["Mage"]:
		var mage = tarot_scenes["mage"].instantiate()
		add_child(mage)
		mage.position = Vector2(260, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(260, 350)
	if global.tarot_cards["Priestess"]:
		var priestess = tarot_scenes["priestess"].instantiate()
		add_child(priestess)
		priestess.position = Vector2(370, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(370, 350)
	if global.tarot_cards["Empress"]:
		var empress = tarot_scenes["empress"].instantiate()
		add_child(empress)
		empress.position = Vector2(480, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(480, 350)
	if global.tarot_cards["Emperor"]:
		var emperor = tarot_scenes["emperor"].instantiate()
		add_child(emperor)
		emperor.position = Vector2(590, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(590, 350)
	if global.tarot_cards["Hierophant"]:
		var hierophant = tarot_scenes["hierophant"].instantiate()
		add_child(hierophant)
		hierophant.position = Vector2(700, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(700, 350)
	if global.tarot_cards["Lovers"]:
		var lovers = tarot_scenes["lovers"].instantiate()
		add_child(lovers)
		lovers.position = Vector2(810, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(810, 350)
	if global.tarot_cards["Chariot"]:
		var chariot = tarot_scenes["chariot"].instantiate()
		add_child(chariot)
		chariot.position = Vector2(920, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(920, 350)
	if global.tarot_cards["Strength"]:
		var strength = tarot_scenes["strength"].instantiate()
		add_child(strength)
		strength.position = Vector2(1030, 350)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(1030, 350)
	if global.tarot_cards["Hermit"]:
		var hermit = tarot_scenes["hermit"].instantiate()
		add_child(hermit)
		hermit.position = Vector2(150, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(150, 460)
	if global.tarot_cards["Wheel of Fortune"]:
		var fortune = tarot_scenes["fortune"].instantiate()
		add_child(fortune)
		fortune.position = Vector2(260, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(260, 460)
	if global.tarot_cards["Justice"]:
		var justice = tarot_scenes["justice"].instantiate()
		add_child(justice)
		justice.position = Vector2(370, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(370, 460)
	if global.tarot_cards["Hanged Man"]:
		var hangedman = tarot_scenes["hangedman"].instantiate()
		add_child(hangedman)
		hangedman.position = Vector2(480, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(480, 460)
	if global.tarot_cards["Death"]:
		var death = tarot_scenes["death"].instantiate()
		add_child(death)
		death.position = Vector2(590, 460)
	else:
		var empty = tarot_scenes["death_empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(590, 460)
	if global.tarot_cards["Temperance"]:
		var temperance = tarot_scenes["temperance"].instantiate()
		add_child(temperance)
		temperance.position = Vector2(700, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(700, 460)
	if global.tarot_cards["Devil"]:
		var devil = tarot_scenes["devil"].instantiate()
		add_child(devil)
		devil.position = Vector2(810, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(810, 460)
	if global.tarot_cards["Tower"]:
		var tower = tarot_scenes["tower"].instantiate()
		add_child(tower)
		tower.position = Vector2(920, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(920, 460)
	if global.tarot_cards["Star"]:
		var star = tarot_scenes["star"].instantiate()
		add_child(star)
		star.position = Vector2(1030, 460)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(1030, 460)
	if global.tarot_cards["Moon"]:
		var moon = tarot_scenes["moon"].instantiate()
		add_child(moon)
		moon.position = Vector2(425, 570)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(425, 570)
	if global.tarot_cards["Sun"]:
		var sun = tarot_scenes["sun"].instantiate()
		add_child(sun)
		sun.position = Vector2(535, 570)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(535, 570)
	if global.tarot_cards["Judgement"]:
		var judgement = tarot_scenes["judgement"].instantiate()
		add_child(judgement)
		judgement.position = Vector2(645, 570)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(645, 570)
	if global.tarot_cards["World"]:
		var world = tarot_scenes["world"].instantiate()
		add_child(world)
		world.position = Vector2(755, 570)
	else:
		var empty = tarot_scenes["empty"].instantiate()
		add_child(empty)
		empty.position = Vector2(755, 570)
