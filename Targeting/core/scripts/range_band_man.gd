extends Node

@export var shape_node: CollisionShape2D
@export var discard_pile: Node

const attachment_name: String = "RangeBandCard"

func flash_shape(val: Shape2D):
	shape_node.shape = val

func attach(card: Node):
	dettach_existing()

	if card.get_parent():
		card.get_parent().remove_child(card)
	
	add_child.call_deferred(card)
	card.name = attachment_name

func dettach_existing():
	var existing: Node = get_node_or_null(attachment_name)
	if existing != null:
		remove_child(existing)
		discard_pile.add_ontop(existing)

func clear():
	dettach_existing()
	clear_targeting()

func clear_targeting():
	shape_node.shape = null