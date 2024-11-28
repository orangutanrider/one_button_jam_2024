extends Node

@export var card_pile: Node

@export var discard_pile: Node

func _ready() -> void:
	for child in get_children():
		child.flash_discard_pile(discard_pile)
	
	card_pile.initialize(self)
