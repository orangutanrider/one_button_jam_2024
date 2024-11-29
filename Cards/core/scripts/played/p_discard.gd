##! When the card is played it is discarded

extends Node

# Internal reference
@export var root: Node

func _ready() -> void:
	root.played.connect(discard_root)

func discard_root():
	root.discarded()