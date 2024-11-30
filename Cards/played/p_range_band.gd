extends Node

# params
@export var range_band: PackedScene

# External reference
@export var range_band_man: Node

func _ready() -> void:
	get_parent().played.connect(played)

func played():
	get_parent().ghost()
	range_band_man.flash_shape(range_band)
	range_band_man.attach(self)
