##! The roller is a no-clipping collider that can extend and retract from a pivot.
##! It will create a pressure value based on how compressed it is.
##! The roller is not expected to be offset in an x-axis direction from its pivot.

extends Node2D

# Parameters
@export var params: TankRollerRes

# Internal variables
var grounded: bool = false
var roller_movement: float = 1.0 
var pressure: float = 0.0

# References created on _ready
var roller: Area2D

func read_pressure() -> float:
	return pressure

## roller_pos is it's y-position contextual to the roller pivot
func pressure_formula(roller_pos: float) -> float:
	return smoothstep(params.EXTENSION_POINT, params.RETRACTION_POINT, roller_pos)

func _ready() -> void:
	roller = $Roller
	roller.area_entered.connect(_contact)
	roller.area_exited.connect(_contact_exit)
	pass

func _physics_process(_delta: float) -> void:
	# Retract when grounded.
	if grounded:
		roller_movement = clampf(roller_movement - params.RETRACTION_ACCEL, -params.RETRACTION_LIMIT, 0.0)
	else: # Extende while not grounded
		roller_movement = clampf(roller_movement + params.EXTENSION_ACCEL, 0.0, params.EXTENSION_LIMIT)

	# new_pos is relative to pivot, 0.0 is pivot's position
	# roller position calculations can be dealt with linearly along y-axis
	var new_pos: float = roller.position.y + roller_movement

	# Position constraints
	if new_pos <= params.RETRACTION_POINT:
		new_pos = params.RETRACTION_POINT
	if new_pos >= params.EXTENSION_POINT:
		new_pos = params.EXTENSION_POINT

	# Set position
	roller.position.y = new_pos
	# Calculate new pressure value
	pressure = pressure_formula(new_pos)

	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func _contact(_area: Area2D) -> void:
	print("entered: grounded")
	grounded = true
	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func _contact_exit(_area: Area2D) -> void:
	print("exited: grounded")
	grounded = false
	pass
