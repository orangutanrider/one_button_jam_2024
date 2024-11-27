##! Uses engine pressure to apply forces to the tank's forward vector

extends Node2D

@export var engine_pressure: Node
@export var params: TankEnginePressureRes

func read_forward_force() -> float:
    return params.curve.sample(engine_pressure.read())
