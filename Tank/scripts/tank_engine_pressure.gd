##! Uses engine pressure to apply forces to the tank's forward vector

extends Node

@export var engine_pressure: NodeReferenceRelayRes
@export var params: TankEnginePressureRes

func read_forward_force() -> float:
	return params.curve.sample(engine_pressure.get_ref().read())
