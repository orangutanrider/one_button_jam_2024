##! A constant force to be applied along a forward-point vector

extends Node

@export var STRENGTH: float = 1.0;

func read_forward_force() -> float:
	return STRENGTH
