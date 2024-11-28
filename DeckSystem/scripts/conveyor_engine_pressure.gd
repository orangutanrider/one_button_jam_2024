extends Node2D

@export var engine_pressure: Node
@export var params: ConveyorSpeedEnginePressureRes

@export var conveyor_belt: Node

func speed_bonus_formula() -> float:
	return engine_pressure.read() * params.SCALAR

func _process(_delta: float):
	conveyor_belt.set_pressure_bonus(speed_bonus_formula())
	pass
