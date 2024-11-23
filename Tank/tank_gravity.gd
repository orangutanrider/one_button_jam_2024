##! Pulls the tank towards its body's down-vector

extends RigidBody2D

@export var GRAV_STRENGTH: float = 1.0;

var grav_point: Node2D

func _ready() -> void:
	grav_point = $GravPoint

func _physics_process(delta: float) -> void:
	var force: Vector2 = (global_position + grav_point.global_position) * GRAV_STRENGTH
	apply_central_force(force)
	pass
