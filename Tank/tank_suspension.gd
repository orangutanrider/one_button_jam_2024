##! Uses pressure values from the rollers to create an opposite force on the body of the tank
##! Forces are positional, so they create rotation 

extends RigidBody2D

@export var ROLLERS: Array[Node2D]
@export var FORCE_SCALAR: float = 1.0

# GravPoint is re-used for the force vector of the rollers (going in the opposite direction)
var grav_point: Node2D

func _ready() -> void:
	grav_point = $GravPoint

func _physics_process(delta: float) -> void:
	var force_direction: Vector2 = -(global_position + grav_point.global_position).normalized()

	for roller in ROLLERS:
		var pressure: float = roller.read_pressure()
		apply_force(force_direction * pressure * FORCE_SCALAR, roller.position)
	pass

# todo
