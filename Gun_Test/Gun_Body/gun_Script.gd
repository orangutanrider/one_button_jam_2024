extends Node2D
@export var bullet_scene: PackedScene
var mainscene

func _ready() -> void:
	mainscene = get_tree().root.get_child(0)

func _on_shoottimer_timeout() -> void:
	var new_bullet: Node2D = bullet_scene.instantiate()
	mainscene.add_child(new_bullet)
	new_bullet.position = get_node("BulletEmitLocation").global_position
	new_bullet.rotation = self.rotation

func _physics_process(delta):
	self.rotation += 0.001
	
