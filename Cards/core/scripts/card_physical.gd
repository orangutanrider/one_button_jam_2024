extends RigidBody2D

# Params
@export var params: CardMovementRes

# Internal node reference
@export var bang: Node
@export var bumper: Area2D
@export var conveyor_movement: Node

var is_ghost: bool = true
var armed: bool = false

func _ready() -> void:
	bang.jettisoned.connect(jettison_trigger)
	bang.armed.connect(armed_trigger)
	bumper.bump.connect(bump_trigger)
	pass

func _physics_process(delta: float) -> void:
	if is_ghost || armed: return

	var motion: Vector2 = Vector2.LEFT * conveyor_movement.read_speed()
	move_and_collide(motion * delta)
	position.y = 0.0

func ghost():
	is_ghost = true
	armed = false

	set_deferred("sleeping", true)
	set_deferred("freeze", true)

	set_deferred("lock_rotation", true)
	set_deferred("rotation", 0.0)
	set_deferred("gravity_scale", 0.0)
	pass

func un_ghost():
	is_ghost = false
	armed = false

	set_deferred("sleeping", false)
	set_deferred("freeze", false)

	set_deferred("lock_rotation", true)
	set_deferred("rotation", 0.0)
	set_deferred("gravity_scale", 0.0)
	pass

# It would make more sense if these parameters were not local to the card but local to the deck system.
func jettison_trigger():
	set_deferred("lock_rotation", false)
	set_deferred("angular_velocity", params.jettison_angular)
	set_deferred("gravity_scale", params.jettison_grav)
	apply_central_impulse(params.jettison_force)
	pass

func armed_trigger():
	armed = true
	set_deferred("gravity_scale", params.armed_grav)

func bump_trigger(motion: float):
	move_and_collide(Vector2.LEFT * motion)
	bumper.cascade()
	pass
