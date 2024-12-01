extends MasterBullet

@export var params: BulletParams

var Fired : bool = 0

func _on_bullet_fired() -> void:
	Fired = 1
	#var velocity = Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	# const Speed = 300
	if Fired:
		velocity = Vector2(params.speed,0).rotated(rotation)
		move_and_slide()

func _on_area_2d_area_entered(body: Area2D) -> void:
	#const Damage = 300
	#if Fired:
	#	if body.collision_layer & (1<<0):
	#		queue_free()
	#	elif body.collision_layer & (1<<1):
	#		print("Enemy Hit")
	#		body.get_parent()._take_damage(Damage)
	#		queue_free()

	body.get_parent()._take_damage(params.damage)
		
