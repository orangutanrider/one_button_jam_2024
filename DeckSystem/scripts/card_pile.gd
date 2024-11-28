extends Node

var count: int = 0

func initialize(init: Node) -> void:
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
	var card_name: String = "card-" + str(count)
	var card: Node2D = find_child(card_name, false, true) 

	if card == null: 
		push_warning("Attempted to find child with name: \"", card_name, "\" but recieved null")
		return 

	remove_child(card)
	count = count - 1
	return card

func add_ontop(card: Node):
	count = count + 1
	card.ghost()
	card.name = "card-" + str(count)
	card.get_parent().remove_child(card)
	add_child.call_deferred(card)
