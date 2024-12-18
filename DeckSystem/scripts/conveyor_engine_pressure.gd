extends Node

@export var engine_pressure: NodeReferenceRelayRes

@export var params: ConveyorEnginePressureRes
@export var conveyor_belt: Node

func speed_bonus_formula() -> float:
	if engine_pressure == null: return 0.0
	return engine_pressure.get_ref().read() * params.SCALAR

func _process(_delta: float):
	conveyor_belt.set_pressure_bonus(speed_bonus_formula())
	pass
