##! Handles the ghosting and un-ghosting of the card

extends Node2D

# External reference
@export var discard_pile: Node

# Internal reference
@export var bang: Node
@export var collision: Node
@export var mover: Node

func _ready() -> void:
	bang.played.connect(played)
	bang.armed.connect(armed)
	bang.discarded.connect(discarded)

func armed():
	collision.ghost()
	pass

func discarded():
	add_to_discard_and_ghost()
	pass

func played():
	add_to_discard_and_ghost()
	pass

func add_to_discard_and_ghost():
	discard_pile.add_ontop(self)
	ghost()
	pass

func ghost():
	visible = false
	bang.ghost()
	mover.ghost()
	pass

# un_ghost callers are todo
func un_ghost():
	visible = true
	bang.un_ghost()
	collision.un_ghost()
	mover.un_ghost()
	pass