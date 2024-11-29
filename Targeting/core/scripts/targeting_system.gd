##! Creates detection in a shape
##! Selects a target

extends Area2D

var params: TargetingSystemRes

enum HardConstraint { NONE, AIR_ONLY, GROUND_ONLY }
var hard_constraint: HardConstraint = HardConstraint.NONE

var target: Area2D = null
var detection: Array[Area2D]

func clear():
	pass

func area_entered():
	pass

func area_exited():
	pass