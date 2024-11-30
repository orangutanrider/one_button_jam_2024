extends Node

@export var discard_pile: NodeReferenceRelayRes
@export var targeting_system: Area2D

var shape_node: Node2D

const attachment_name: String = "RangeBandCard"

func flash_shape(scene: PackedScene):
	shape_node = scene.instantiate()
	var pos: Vector2 = shape_node.position
	targeting_system.add_child(shape_node)
	shape_node.position = pos

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
		discard_pile.get_ref().add_ontop(existing)

func clear():
	dettach_existing()
	clear_targeting()

func clear_targeting():
	shape_node.queue_free()
	