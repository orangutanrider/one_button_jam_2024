extends Node

## Optional initialization cards
@export var init: Node

var count: int = 0

func _ready() -> void:
	if init == null: return

	var stack = init.get_children()
	stack.shuffle()
	for card in stack:
		add_ontop(card)
	pass

func read_count() -> int:
	return count

func is_empty() -> bool:
	if count <= 0:
		return true
	else:
		return false

## use is_empty() before using this function
## It is expected that the caller will take the card out of this node's hierarchy
## It is also expected that the caller will be the one to ghost or un-ghost the card
func draw_a_card() -> Node2D:
	# you might be able to use get_child here instead
	var card: Node2D = find_child("card-" + str(count), false, true) 
	count = count - 1
	return card

func add_ontop(card: Node):
	count = count + 1
	card.make_ghost()
	card.name = "card-" + str(count)
	add_child(card)
