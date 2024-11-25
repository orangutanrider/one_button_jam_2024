extends MasterBullet

var Fired : bool = 0
const Speed = 300

func _on_bullet_fired() -> void:
	Fired = 1
	var velocity = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	if Fired:
		velocity = Vector2(Speed,0).rotated(rotation)
		move_and_slide()
