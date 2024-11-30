##! When the card is played it is discarded

extends Node

func _ready() -> void:
	get_parent().played.connect(played)

func played():
	get_parent().discarded()