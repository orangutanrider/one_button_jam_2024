extends Node2D

@export var rotate_speed: float = 1.0

func _process(delta: float):
	rotate(rotate_speed * delta)