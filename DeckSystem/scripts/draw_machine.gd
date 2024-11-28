extends Node

# Params
@export var params: DrawMachineRes

# Scene references
@export var draw_pile: Node
@export var discard_pile: Node

var draw_timer: float = 0.0

func _process(delta: float) -> void:
	draw_timer = draw_timer + delta

	if draw_timer > 1 / params.draw_rate:
		draw_timer = 0.0
		draw_card_onto_conveyor()

func draw_card_onto_conveyor():
	if draw_pile.is_empty():
		shuffle_discard_into_draw()
	
	var card: Node2D = draw_pile.draw_a_card()
	if card == null: 
		push_warning("Attempted to draw a card but got null, this indicates that the deck has no remaining cards; Unexpected.")
		return # If deck is empty, should never happen
	
	add_child(card)
	card.position = Vector2.ZERO
	card.draw_trigger()

func shuffle_discard_into_draw():
	var cards: Array[Node]

	var i: int = 0
	while i < discard_pile.read_count():
		cards.push_back(discard_pile.draw_a_card())
		i = i + 1

	cards.shuffle()

	for card in cards:
		draw_pile.add_ontop(card)
