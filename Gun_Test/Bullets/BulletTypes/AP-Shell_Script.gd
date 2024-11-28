extends MasterBullet

var Fired : bool = 0

func _on_bullet_fired() -> void:
	Fired = 1

func _on_area_2d_area_entered(body) -> void:
	const Damage = 300
	if Fired:
		if body.collision_layer & (1<<0):
			queue_free()
		elif body.is_in_group("enemy"):
			print("Enemy Hit")
			body.get_parent()._take_damage(Damage)
			queue_free()
		
