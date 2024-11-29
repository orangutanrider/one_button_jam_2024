extends MasterBullet

const Speed = 300
var Fired : bool = 0
var ExplosionRef = load("res://Gun_Test/Bullets/Explosion.tscn")
var mainscene

func _on_bullet_fired() -> void:
	Fired = 1
	var velocity = Vector2.RIGHT
	mainscene = get_tree().root.get_child(0)

func _physics_process(delta: float) -> void:
	if Fired:
		velocity = Vector2(Speed,0).rotated(rotation)
		move_and_slide()

func _on_area_2d_area_entered(body) -> void:
	const Damage = 300
	if Fired:
		_Explode()
		queue_free()

func _Explode() -> void:
	var Explosion = ExplosionRef.instantiate()
	mainscene.add_child(Explosion)
	Explosion.position = self.global_position
	queue_free()
	
