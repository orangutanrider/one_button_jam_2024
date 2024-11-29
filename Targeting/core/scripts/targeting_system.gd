##! Creates detection in a shape
##! Selects a target

extends Area2D

var params: TargetingSystemRes

enum HardConstraint { NONE, AIR_ONLY, GROUND_ONLY }
var hard_constraint: HardConstraint = HardConstraint.NONE

var target: Area2D = null
var detection: Dictionary

func clear():
	detection.clear()
	target = null

# Detection
func area_entered(area: Area2D):
	if hard_constraint == HardConstraint.NONE:
		detection.get_or_add(area, null)
		return
	
	if hard_constraint == HardConstraint.AIR_ONLY && area.is_airborne_type():
		detection.get_or_add(area, null)
		return
	
	if hard_constraint == HardConstraint.GROUND_ONLY && !area.is_airborne_type():
		detection.get_or_add(area, null)
		return

func area_exited(area: Area2D):
	detection.erase(area)

