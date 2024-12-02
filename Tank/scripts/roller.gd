extends Node2D

@export var rotate_speed: float = 1.0

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	rotate(rng.randf_range(0, 6.28319))

func _process(delta: float):
	rotate(rotate_speed * delta)
