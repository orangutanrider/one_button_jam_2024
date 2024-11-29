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
	var relative: Vector2 = target.global_position - global_position
	var hypo: float = relative.distance_to(target.global_position)
	var angle: float = sin(relative.y/hypo)

	# rotation
	var diff: float = rotation - angle
	var turn_power = clampf(diff, (-params.turn_rate * delta), (params.turn_rate * delta))
	rotate(turn_power)