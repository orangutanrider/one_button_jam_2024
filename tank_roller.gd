extends Node2D

# Immutable parameters
@export var ROLLER_SHAPE: CapsuleShape2D
# The maximum spring compression value used in equations
# Extension point is taken as the height of the ROLLER_SHAPE parameter
@export var COMPRESSION_POINT: float = 1.0
@export var ROLLER_WEIGHT: float = 1.0
@export var SPRING_POWER: float = 1.0

# References
@export var TANK_BODY: RigidBody2D

# Instantiated references
var roller_area: Area2D
var roller_shape: CollisionShape2D

# Internal variables
var grounded: bool = false

# The maximum spring extension value used in equations
func read_extension_point() -> float:
	return ROLLER_SHAPE.height

func read_roller_extension() -> float: 
	var capsule: CapsuleShape2D = roller_shape.shape
	return capsule.height

func set_roller_extension(val: float) -> void:
	# todo
	pass

# 0.0 to 1.0 formula
func spring_formula(compression_point: float, extension_point: float, x: float) -> float:
	return smoothstep(compression_point, extension_point, x)

func _ready() -> void:
	# Create objects
	roller_area = Area2D.new()
	roller_shape = CollisionShape2D.new()
	# Set params
	roller_shape.shape = ROLLER_SHAPE

	# Connect events
	roller_area.area_entered.connect(contact)
	roller_area.area_exited.connect(contact_exit)

	# Add to hierarchy
	add_child(roller_area)
	roller_area.add_child(roller_shape)
	pass

func _physics_process(delta: float) -> void:
	var roller_dist: float = read_roller_extension()
	var extension_point_: float = read_extension_point()

	var retraction_scalar: float = spring_formula(COMPRESSION_POINT, extension_point_, roller_dist) 
	var expansion_scalar: float = spring_formula(extension_point_, COMPRESSION_POINT, roller_dist) 

	var expansion_force: float = expansion_scalar * SPRING_POWER
	var retraction_force: float = -retraction_scalar * SPRING_POWER

	# Spring forces on roller
	var roller_movement: float = (expansion_force + retraction_force) * (1 / ROLLER_WEIGHT)
	if grounded:
		roller_movement = clampf(roller_movement, roller_movement, 0.0) # Cannot expand while grounded
	set_roller_extension(roller_dist + roller_movement)

	# Todo
	# Raycast downwards to get ground hit position
	# Use to push the roller upwards to the point of the ground

	# Todo
	# Apply gravity to the roller while not grounded

	# Todo
	# Apply a positional and directional force to the tank's body 
	# Utilising the rotation and location of the roller origin
	# And the compression and expansion forces of the spring

	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func contact(area: Area2D) -> void:
	grounded = true
	pass

# For now it is expected that the only valid collision are ones that are intended to be grounding; It is expected that layermasks will handle this.
func contact_exit(area: Area2D) -> void:
	grounded = false
	pass
