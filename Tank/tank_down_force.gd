##! A constant force to be applied along a grav-point vector

extends Node

@export var STRENGTH: float = 1.0;

func read_down_force() -> float:
	return STRENGTH
