##! The roller is a no-clipping collider that can extend and retract from a pivot.
##! It will create a pressure value based on how compressed it is.
##! It is not expected to be offset in an x-axis direction from its pivot.

# todo: Create parameters as a resource-type so they can easily be shared across multiple rollers in a scene

extends Node2D

# Resources
@export var ROLLER_SHAPE: CapsuleShape2D

# Parameters
## The distance from the roller's pivot at which the roller is no longer allowed to retract
@export var RETRACTION_POINT: float = 1.0 
@export var RETRACTION_ACCEL: float = 0.01
## The speed limit of the retraction movement
@export var RETRACTION_LIMIT: float = 2.0
## The maximum distance away from the roller's pivot at which the roller is no longer allowed to extend
@export var EXTENSION_POINT: float = 10.0
@export var EXTENSION_ACCEL: float = 0.01
## The speed limit of the extension movement
@export var EXTENSION_LIMIT: float = 2.0

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
	return smoothstep(EXTENSION_POINT, RETRACTION_POINT, roller_pos)

func _ready() -> void:
	roller = $Roller
	pass

func _physics_process(delta: float) -> void:
	# Retract when grounded.
	if grounded:
		roller_movement = clampf(roller_movement - RETRACTION_ACCEL, -RETRACTION_LIMIT, 0.0)
	else: # Extende while not grounded
		roller_movement = clampf(roller_movement + EXTENSION_ACCEL, 0.0, EXTENSION_LIMIT)

	# new_pos is relative to pivot, 0.0 is pivot's position
	# roller position calculations can be dealt with linearly along y-axis
	var new_pos: float = roller.position.y + roller_movement

	# Position constraints
	if new_pos <= RETRACTION_POINT:
		new_pos = RETRACTION_POINT
	if new_pos >= EXTENSION_POINT:
		new_pos = EXTENSION_POINT

	# Set position
	roller.position.y = new_pos
	# Calculate new pressure value
	pressure = pressure_formula(new_pos)

	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func contact(area: Area2D) -> void:
	grounded = true
	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func contact_exit(area: Area2D) -> void:
	grounded = false
	pass
