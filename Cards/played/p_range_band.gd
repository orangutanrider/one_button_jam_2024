extends Node

# params
@export var range_band: PackedScene

# External reference
@export var range_band_man: NodeReferenceRelayRes

func _ready() -> void:
	get_parent().played.connect(played)

func played():
	get_parent().ghost()
	range_band_man.get_ref().flash_shape(range_band)
	range_band_man.get_ref().attach(get_parent())
