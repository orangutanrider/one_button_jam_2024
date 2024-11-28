##! Handles the ghosting and un-ghosting of the card

extends Node2D

# External reference
@export var discard_pile: Node

# Internal reference
@export var bang: Node
@export var collision: Node
@export var physical: Node

func flash_discard_pile(flash: Node):
	discard_pile = flash
	
func draw_trigger():
	# todo: animation
	un_ghost()
	pass

func _ready() -> void:
	bang.played.connect(played)
	bang.armed.connect(armed)
	bang.discarded.connect(discarded)
	ghost()

func armed():
	collision.ghost()
	pass

func discarded():
	ghost()
	discard_pile.add_ontop(self)
	pass

func played():
	ghost()
	discard_pile.add_ontop(self)
	pass

func ghost():
	visible = false
	bang.ghost()
	physical.ghost()
	pass

func un_ghost():
	visible = true
	bang.un_ghost()
	collision.un_ghost()
	physical.un_ghost()
	pass
