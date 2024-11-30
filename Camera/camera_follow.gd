extends RigidBody2D

@export var params: CameraRes

@export var swivel: Node2D

func pull_formula(dist: float) -> float:
	return dist * params.pull_strength

func _physics_process(delta: float) -> void:
	var target_pos: Vector2 = swivel.global_position
	var target_dir: Vector2 = (swivel.global_position - global_position).normalized()
	var dist: float = global_position.distance_to(target_pos)

	apply_central_force(target_dir * pull_formula(dist) * delta)

	#var clockwise: Vector2 = target_dir.orthogonal()
	#var clockwise_mag: float = (clockwise - target_dir).length()
	#var anti_clockwise_mag: float = (-clockwise - target_dir).length()

	pass
