extends Area2D

@export var params: DetectableBodyRes

enum TraversalType { Airborne, Grounded }

func is_airborne_type() -> bool: 
	if params.traversal_type == TraversalType.Airborne:
		return true
	else: 
		return false
