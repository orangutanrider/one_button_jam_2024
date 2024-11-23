extends Node2D

# Resources
@export var ROLLER_SHAPE: CapsuleShape2D

# Parameters
@export var GROUND_RETRACTION_FORCE: float = 1.0

# Internal variables
var grounded: bool = false

func _physics_process(delta: float) -> void:
	# Retract when grounded at a constant or instantaneous rate.
	# Create a pressure value when retracted that pushes the body upwards.
	
	# Do not retract beyond the the roller pivot
	# Do not rotate the roller pivot; It is fine if the tank itself rotates though

	# Expose the pressure value so that the body may use it to apply forces to itself, rather than the roller applying forces to the body
	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func contact(area: Area2D) -> void:
	grounded = true
	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func contact_exit(area: Area2D) -> void:
	grounded = false
	pass
