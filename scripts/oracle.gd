extends Panel


var tarot_scenes = {
	"Fool": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_fool.tscn"),
	"Mage": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_mage.tscn"),
	"Priestess": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_priestess.tscn"),
	"Empress": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_empress.tscn"),
	"Emperor": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_emperor.tscn"),
	"Hierophant": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_hierophant.tscn"),
	"Lovers": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_lovers.tscn"),
	"Chariot": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_chariot.tscn"),
	"Strength": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_strength.tscn"),
	"Hermit": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_hermit.tscn"),
	"Wheel of Fortune": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_fortune.tscn"),
	"Justice": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_justice.tscn"),
	"Hanged Man": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_hangedman.tscn"),
	"Death": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_death.tscn"),
	"Temperance": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_temperance.tscn"),
	"Devil": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_devil.tscn"),
	"Tower": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_tower.tscn"),
	"Star": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_star.tscn"),
	"Moon": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_moon.tscn"),
	"Sun": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_sun.tscn"),
	"Judgement": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_judgement.tscn"),
	"World": preload("res://tarots/tarot scenes/unlocking_tarots/unlocked_world.tscn"),
}


# List of all card names
var card_names = global.tarot_cards.keys()

func _ready():
	# Step 1: Get all locked cards (not unlocked)
	var locked_cards = []
	for card_name in card_names:
		if not global.tarot_cards[card_name]:  # Check if the card is locked (false)
			locked_cards.append(card_name)
			print("Locked card: ", card_name)  # Debugging to check which cards are locked

	print("Locked cards count: ", locked_cards.size())  # Check the number of locked cards

	# Step 2: Randomly select locked cards
	var selected_cards = []

	# If there are locked cards, proceed to select them
	if locked_cards.size() > 0:
		# If there are 3 or more locked cards, select randomly up to 3
		if locked_cards.size() >= 3:
			while selected_cards.size() < 3:
				var rand_index = randi() % locked_cards.size()
				var selected_card = locked_cards[rand_index]

				# Avoid duplicates
				if not selected_card in selected_cards:
					selected_cards.append(selected_card)
		# If there are less than 3 locked cards, just add them all
		else:
			selected_cards = locked_cards  # Simply take all available locked cards

	print("Selected cards: ", selected_cards)  # Check the selected cards

	# Step 3: Add the selected locked cards in a horizontal line (left to right)
	var screen_width = get_viewport().size.x  # Get the screen width
	var x_offset = screen_width / 2  # Start with the center of the screen
	var spacing = 200  # Space between the cards

	for index in range(selected_cards.size()):
		var card_name = selected_cards[index]

		if tarot_scenes.has(card_name):  # Ensure the scene exists
			var card = tarot_scenes[card_name].instantiate()

			# Position the card
			# First card goes in the middle, the second one goes to the left, etc.
			if index == 0:
				card.position = Vector2(x_offset, 400)  # First card in the center
			elif index == 1:
				card.position = Vector2(x_offset - spacing, 400)  # Second card to the left
			elif index == 2:
				card.position = Vector2(x_offset + spacing, 400)  # Third card to the right

			# Add the card to the parent (usually the Oracle node)
			add_child(card)
