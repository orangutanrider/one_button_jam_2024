##! Handles the engine pressure resource
##! Does not apply the engine pressure forces to the tank

extends Node

@export var params: EnginePressureScriptRes

var engine_pressure: float = 0.0

func engine_pressure_decay_formula(engine_pressure_val: float, delta: float) -> float:
    return -((delta * (params.exponent_decay_strength ** engine_pressure_val)) + delta * params.linear_decay_strength)

func _process(delta: float) -> void:
    if engine_pressure <= 0.0:
        engine_pressure = 0.0
        return
    
    engine_pressure = engine_pressure - engine_pressure_decay_formula(engine_pressure, delta)
    pass

func increase_engine_pressure(value: float):
    engine_pressure = engine_pressure + value
    pass
