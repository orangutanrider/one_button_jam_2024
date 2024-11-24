extends Node2D

@export var PARAMS: TankSuspensionRes
@export var ROLLER: Node2D

var force_strength: float = 0.0

func read_positioned_up_force_position() -> Vector2:
	return position # todo

func read_positioned_up_force_strength() -> float:
	return force_strength # todo

func _physics_process(_delta: float) -> void:
	force_strength = ROLLER.read_pressure() * PARAMS.FORCE_SCALAR
	pass
