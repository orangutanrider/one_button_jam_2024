##! Creates detection in a shape
##! Selects a target

extends Area2D

@export var params: TargetingSystemRes

enum HardConstraint { NONE, AIR_ONLY, GROUND_ONLY }
var hard_constraint: HardConstraint = HardConstraint.NONE

var target: Area2D = null
var detection: Dictionary

var clock: float = 0.0

func read() -> Area2D:
	return target

func clear():
	detection.clear()
	target = null

# Detection
func _area_entered(area: Area2D):
	if hard_constraint == HardConstraint.NONE:
		detection.get_or_add(area, null)
		return
	
	if hard_constraint == HardConstraint.AIR_ONLY && area.is_airborne_type():
		detection.get_or_add(area, null)
		return
	
	if hard_constraint == HardConstraint.GROUND_ONLY && !area.is_airborne_type():
		detection.get_or_add(area, null)
		return

func _area_exited(area: Area2D):
	if target == area:
		target = null
	detection.erase(area)

# Node
func _ready() -> void:
	area_entered.connect(_area_entered)
	area_exited.connect(_area_exited)
	pass

func _process(delta: float) -> void:
	if clock < params.clock_time:
		clock = clock + delta
		return

	if target != null: return

	var detected: Array = detection.keys()
	if detected.size() == 0: return
	
	clock = 0.0
	target = detected[0]
