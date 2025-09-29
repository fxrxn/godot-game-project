extends Node
var fire = false
var water = false
var metal = false
var collected_wood: int = 0
var current_matches: int = 0
var steps: int = 0
var campfire_number: int = 0
var loot_collected: int = 0
var goal: int = 0
var sanity: int = 100
var max_sanity: int = 50
var intro_skip = false
var firekits_unlocked = false
var firekit = 0 
var sanity_loss: int = 5
var fallen = false
var player_name: String = "Carp"
var player_name_given = false
var recovering = false
var zoom_recovery = 0
var recovery_steps = 3

var first_wood = true
var second_wood = true
var step_luck = 0
var wearing_warm_boots = false
var wearing_spiky_boots = false
var wearing_warm_gloves = false
var wearing_sun_idol = false
var wearing_moon_idol = false
var wearing_sturdy_gloves = false
var found_sunidol = false
var found_moonidol = false
var found_warm_gloves = false
var found_sturdy_gloves = false
var found_warm_boots = false
var found_spiky_boots = false

var unlocked_equipment = false
var unlocked_sunidol = false
var unlocked_moonidol = false
var unlocked_warm_gloves = false
var unlocked_sturdy_gloves = false
var unlocked_warm_boots = false
var unlocked_spiky_boots = false

func reset():
	print("reseted")
	var fire = false
	var water = false
	var metal = false

	found_warm_gloves = false
	found_sturdy_gloves = false
	found_warm_boots = false
	found_spiky_boots = false
	found_sunidol = false
	found_moonidol = false

	wearing_sturdy_gloves = false
	wearing_warm_boots = false
	wearing_spiky_boots = false
	wearing_warm_gloves = false
	wearing_sun_idol = false
	wearing_moon_idol = false
	firekits_unlocked = false
	firekit = 0
	print("game_reset")
	tarot_equipped = 0
	loot_collected = 0
	campfire_number = 0
	sanity = max_sanity
	goal = 0
	steps = 0
	collected_wood = 0
	current_matches = max_matches
	max_matches = 20
	max_warmth = 100
	max_sanity = 50
	fool_active = false  
	mage_active = false  
	priestess_active = false  
	empress_active = false  
	emperor_active = false  
	hierophant_active = false  
	lovers_active = false  
	chariot_active = false  
	strength_active = false  
	hermit_active = false  
	fortune_active = false  
	justice_active = false  
	hangedman_active = false  
	death_active = false  
	temperance_active = false  
	devil_active = false  
	tower_active = false  
	star_active = false  
	moon_active = false  
	sun_active = false  
	judgement_active = false  
	world_active = false  
	print(tarot_equipped)
# boots

func equip_item(item_name: String) -> void:
	match item_name:
		"warm_boots":
			if not global.wearing_warm_boots:
				global.step_cost -= 1
				global.wearing_warm_boots = true

		"spiky_boots":
			if not global.wearing_spiky_boots:
				global.wearing_spiky_boots = true

		"warm_gloves":
			if not global.wearing_warm_gloves:
				global.step_cost -= 1
				global.wearing_warm_gloves = true

		"sturdy_gloves":
			if not global.wearing_sturdy_gloves:
				global.wood_cost -= 1
				global.wearing_sturdy_gloves = true

		"sun_idol":
			if not global.wearing_sun_idol:
				global.step_cost -= 1
				global.wearing_sun_idol = true

		"moon_idol":
			if not global.wearing_moon_idol:
				global.wearing_moon_idol = true
				


func unequip_item(item_name: String) -> void:
	match item_name:
		"warm_boots":
			if global.wearing_warm_boots:
				global.step_cost += 1
				global.wearing_warm_boots = false

		"spiky_boots":
			global.wearing_spiky_boots = false

		"warm_gloves":
			if global.wearing_warm_gloves:
				global.step_cost += 1
				global.wearing_warm_gloves = false

		"sturdy_gloves":
			if global.wearing_sturdy_gloves:
				global.wood_cost += 1
				global.wearing_sturdy_gloves = false

		"sun_idol":
			if global.wearing_sun_idol:
				global.step_cost += 1
				global.wearing_sun_idol = false

		"moon_idol":
			global.wearing_moon_idol = false


var tarots_unlocked = true 


var fool_active = false
var fool_update = true
var fool_extra = true  

var mage_active = false
var mage_update = false  
var mage_extra = false  

var priestess_active = false
var priestess_update = false  
var priestess_extra = false  

var empress_active = false
var empress_update = false  
var empress_extra = false  

var emperor_active = false
var emperor_update = false  
var emperor_extra = false  

var hierophant_active = false
var hierophant_update = false  
var hierophant_extra = false  

var lovers_active = false
var lovers_update = false  
var lovers_extra = false  

var chariot_active = false
var chariot_update = false  
var chariot_extra = false  

var strength_active = false
var strength_update = false  
var strength_extra = false  

var hermit_active = false
var hermit_update = false  
var hermit_extra = false  

var fortune_active = false
var fortune_update = false  
var fortune_extra = false  

var justice_active = false
var justice_update = false  
var justice_extra = false  

var hangedman_active = false
var hangedman_update = false  
var hangedman_extra = false  

var death_active = false  

var temperance_active = false
var temperance_update = false  
var temperance_extra = false  

var devil_active = false
var devil_update = false  
var devil_extra = false  

var tower_active = false
var tower_update = false  
var tower_extra = false  

var star_active = false
var star_update = false  
var star_extra = false  

var moon_active = false
var moon_update = false  
var moon_extra = false  

var sun_active = false
var sun_update = false  
var sun_extra = false  

var judgement_active = false
var judgement_update = false  
var judgement_extra = false  

var world_active = false
var world_update = true  
var world_extra = true  



var max_wood: int = 2 #maximum amount of wood
var wood_amount: int = 1 #amount of wood that is collected from one wood node
var wood_cost: int = 2 #amount of warmth it costs to collect one wood node
var max_warmth: int = 100 #maximum warmth
var step_cost: int = 3 # cost for taking a step changed from 5
var max_matches: int = 20  # Maximum number of matches the player can carry
var warmth_increase_amount: int = 5  # Amount of warmth gained per match
var loot_cost: int = 3  #warmth cost for looting
var warmth_amount: int = 5  # Amount of warmth provided from campfire
var maxcampfire: int = 20  # Number of times warmth is provided before destruction
var campfire_range: int = 12  # Determines if the range is 8
var campfire_cost: int = 1 #warmth cost for setting up campfires
var campfire_match_cost: int = 1
var match_held: bool = false  # Tracks whether the match is currently held
var tarot_equipped: int = 0
var max_tarot: int = 3
var match_protection: int = 0 # how much less sanity you will lose while a match is active
var bonus_sanity:int = 0 #bonus sanity everytime you gain sanity
var shop_discount:int = 0
var shop_exists: bool = false
var gambling: bool = false
var gambling_luck: int = 0
var less_events: int = 0
var sanity_protection: int = 0 #lose less sanity from events
var campfire_sanity: int = 0
var item_awareness: int = 0
var weather_protection: int = 0 #lose less warmth from weather events
var love: bool = false
var lovesteps_counter_max: int = 0
var lovesteps_current: int = 0
var summit_fever: bool = false
var max_summit_fever: int = 0
var summit_fever_steps: int = 0
var star_steps: bool = false
var star_steps_count: int = 0
var tarot_cards = {
	"Fool": false,
	"Mage": false,
	"Priestess": false,
	"Empress": false,
	"Emperor": false,
	"Hierophant": false,
	"Lovers": false,
	"Chariot": false,
	"Strength": false,
	"Hermit": false,
	"Wheel of Fortune": false,
	"Justice": false,
	"Hanged Man": false,
	"Death": false,
	"Temperance": false,
	"Devil": false,
	"Tower": false,
	"Star": false,
	"Moon": false,
	"Sun": false,
	"Judgement": false,
	"World": false
}


func tarot_check():
	if fool_active:
		if fool_extra:
			step_cost = 2
		else:
			if fool_update:
				step_cost = 3
			else:
				step_cost = 4
	## else: 
		# step_cost = 5
		# print("fool is not checked")
	if mage_active:
		if mage_extra:
			campfire_cost = 2
		else:
			if mage_update:
				campfire_cost = 3
			else:
				campfire_cost = 4
	else:
		campfire_cost = 5

	if priestess_active:
		if priestess_extra:
			match_protection = 5
		else:
			if priestess_update:
				match_protection = 3
			else:
				match_protection = 2
	else:
		match_protection = 0

	if empress_active:
		if empress_extra:
			maxcampfire = 8
		else:
			if empress_update:
				maxcampfire = 7
			else:
				maxcampfire = 6
	else:
		maxcampfire = 5

	if emperor_active:
		if emperor_extra:
			wood_cost = 0
		else:
			if emperor_update:
				wood_cost = 1
			else:
				wood_cost = 3
	else: 
		wood_cost = 5

	if hierophant_active:
		if hierophant_extra:
			bonus_sanity = 3
		else:
			if hierophant_update:
				bonus_sanity = 2
			else:
				bonus_sanity = 1
	else:
		bonus_sanity = 0

	if lovers_active:
		love = true
		if lovers_extra:
			lovesteps_counter_max = 10
		else:
			if lovers_update:
				lovesteps_counter_max = 5
			else:
				lovesteps_counter_max = 3
	else:
		love = false
		lovesteps_counter_max = 0

	if chariot_active:
		summit_fever = true
		if chariot_extra:
			max_summit_fever = 30
		else:
			if chariot_update:
				max_summit_fever = 25
			else:
				max_summit_fever = 20
				print(max_summit_fever)
	else:
		summit_fever = false
		max_summit_fever = 0
	

	if strength_active:
		if strength_extra:
			max_wood = 6
		else:
			if strength_update:
				max_wood = 5
			else:
				max_wood = 4
	else:
		max_wood = 2

	if hermit_active:
		shop_exists = true
		if hermit_extra:
			shop_discount = 3
		else:
			if hermit_update:
				shop_discount = 2
			else:
				shop_discount = 1
	else: 
		shop_exists = false
		shop_discount = 0

	if fortune_active:
		gambling = true
		if fortune_extra:
			gambling_luck = 2
		else:
			if fortune_update:
				gambling_luck = 1
			else:
				gambling_luck = 0
	else:
		gambling = false
		gambling_luck = 0

	if justice_active:
		if justice_extra:
			less_events = 3
		else:
			if justice_update:
				less_events = 2
			else:
				less_events = 1
	else:
		less_events = 0

	if hangedman_active:
		if hangedman_extra:
			sanity_protection = 5
		else:
			if hangedman_update:
				sanity_protection = 3
			else:
				sanity_protection = 2
	else: 
		sanity_protection = 0

	if death_active:
		print("foolish")
	else:
		print("wise")

	if temperance_active:
		if temperance_extra:
			campfire_sanity = 3
		else:
			if temperance_update:
				campfire_sanity = 2
			else:
				campfire_sanity = 1
	else:
		campfire_sanity = 0

	if devil_active:
		if devil_extra:
			max_matches += 10
			collected_wood += 2
		else:
			if devil_update:
				max_matches += 7
				collected_wood += 2
			else:
				max_matches += 5
				collected_wood += 2
	else:
		print("i guess you are good")

	if tower_active:
		max_warmth -= 40
		if tower_extra:
			max_matches += 30
		else:
			if tower_update:
				max_matches += 20
			else:
				max_matches += 10
	else:
		print(max_warmth + max_matches)

	if star_active:
		star_steps = true
		if star_extra:
			star_steps_count = 50
		else:
			if star_update:
				star_steps_count = 30
			else:
				star_steps_count = 20
	else:
		star_steps = false
		star_steps_count = 0

	if moon_active:
		campfire_match_cost = 2
		if moon_extra:
			item_awareness = 3
			sanity_loss = 2
		else:
			if moon_update:
				item_awareness = 2
				sanity_loss = 3
			else:
				item_awareness = 1
				sanity_loss = 4
	else:
		campfire_match_cost = 1
		item_awareness = 0

	if sun_active:
		if sun_extra:
			warmth_increase_amount = 10
		else:
			if sun_update:
				warmth_increase_amount = 8
			else:
				warmth_increase_amount = 6
	else: 
		warmth_increase_amount = 5

	if judgement_active:
		if judgement_extra:
			weather_protection = 10
		else:
			if judgement_update:
				weather_protection = 8
			else:
				weather_protection = 5
	else:
		weather_protection = 0

	if world_active:
		if world_extra:
			campfire_range = 30
		else:
			if world_update:
				campfire_range = 24
			else:
				campfire_range = 20
	campfire_range = 12

func lose_sanity():
	sanity -= sanity_loss
