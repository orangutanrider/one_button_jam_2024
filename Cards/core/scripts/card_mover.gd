extends RigidBody2D

@export var params: CardMovementRes

@export var conveyor_movement: Node

func _physics_process(delta: float) -> void:
	var motion: Vector2 = Vector2.LEFT * conveyor_movement.read_speed()
	move_and_collide(motion * delta)

func ghost():
	sleeping = true
	freeze = true

	lock_rotation = true
	rotation = 0.0
	gravity_scale = 0.0
	pass

func un_ghost():
	sleeping = false
	freeze = false

	lock_rotation = true
	rotation = 0.0
	gravity_scale = 0.0
	pass

func jettison_trigger():
	lock_rotation = false
	angular_velocity = params.jettison_angular
	gravity_scale = params.jettison_grav
	pass
