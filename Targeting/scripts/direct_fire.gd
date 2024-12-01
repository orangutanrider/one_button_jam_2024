##! Will aim the weapon directly at the targets

extends Node2D

@export var params: DirectFireRes
@export var targeting: Area2D

func _process(delta: float) -> void:
	var target = targeting.read()
	if target == null:
		return_to_neutral(delta)
	else: 
		aim_at_target(delta, target)

func return_to_neutral(delta: float):
	var diff: float = params.neutral_angle - rotation 
	var turn_power = clampf(diff, (-params.turn_rate * delta), (params.turn_rate * delta))
	rotate(turn_power)

func aim_at_target(delta: float, target: Area2D):
	# pythag
	var relative: Vector2 = global_position - target.global_position 
	var hypo: float = Vector2.ZERO.distance_to(relative)
	var angle: float = -relative.y / hypo
	

	# rotation
	var diff: float = angle - rotation
	var turn_power = clampf(diff, (-params.turn_rate * delta), (params.turn_rate * delta))
	rotate(turn_power)
