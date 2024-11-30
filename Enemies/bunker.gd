extends Enemy
@export var slowEffect = 10
@export var armour = 50
@onready var spriteAnimator = $AnimatedSprite2D
var attacking : bool = false
var stopTimer : float = 0
var stopDuration : float = 0.5

func _prep() -> void:
	projectile_scene = preload("res://Enemies/bunker_projectile.tscn")
	print("bunker spawned")

func _action_updates(delta: float):
	if attacking:
		stopTimer += delta
		spriteAnimator.play("attack")
		if stopTimer > stopDuration:
			attacking = false
			stopTimer = 0
	else:
		spriteAnimator.play("default")

func _take_damage(damage: int) -> void :
	hp -= damage * (armour/100+armour)

func _attack_extention() -> void:
	attacking = true
