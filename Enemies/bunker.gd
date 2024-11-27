extends Enemy
@export var slowEffect = 10
@export var armour = 50


func _prep() -> void:
	projectile_scene = preload("res://Enemies/bunker_projectile.tscn")
	print("bunker spawned")

func _take_damage(damage: int) -> void :
	hp -= damage * (armour/100+armour)
