extends Node

@export var shells: Array[PackedScene]
@export var cannon: Node

func _ready() -> void:
	get_parent().played.connect(played)

func played():
	cannon.AddNewBullets(shells)
