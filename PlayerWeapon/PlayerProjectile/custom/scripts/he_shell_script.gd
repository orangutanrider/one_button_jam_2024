extends MasterBullet

@export var params: BulletParams
@export var explosion_scene: PackedScene

var Fired : bool = 0
var mainscene

func _on_bullet_fired() -> void:
	Fired = 1
	#var velocity = Vector2.RIGHT
	mainscene = get_tree().root.get_child(0)

func _physics_process(_delta: float) -> void:
	if Fired:
		velocity = Vector2(params.speed, 0).rotated(rotation)
		move_and_slide()

func _on_area_2d_area_entered(_body: Area2D) -> void:
	#const Damage = 300
	if Fired:
		_Explode()
		queue_free()

func _Explode() -> void:
	var explosion = explosion_scene.instantiate()
	mainscene.add_child(explosion)
	explosion.position = self.global_position
	queue_free()
	
