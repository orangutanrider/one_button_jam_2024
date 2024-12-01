extends Node

@export var shells: Array[PackedScene]
@export var cannon: NodeReferenceRelayRes

func _ready() -> void:
	get_parent().played.connect(played)

func played():
	cannon.get_ref().AddNewBullets(shells)
