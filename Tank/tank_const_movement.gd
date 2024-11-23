##! Moves the tank forward at a basic constant rate

extends RigidBody2D

@export var POWER: float = 1.0;

var forward_point: Node2D

func _ready() -> void:
	forward_point = $ForwardPoint

func _physics_process(delta: float) -> void:
	var force: Vector2 = (global_position + forward_point.global_position).normalized() * POWER
	apply_central_force(force)
	pass
