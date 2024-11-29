extends Node

# params
@export var range_band: Shape2D

# Internal reference
@export var root: Node
@export var range_band_man: Node

func _ready() -> void:
	root.played.connect(played)

func played():
	root.ghost()
	range_band_man.flash_shape(range_band)
	range_band_man.attach(self)