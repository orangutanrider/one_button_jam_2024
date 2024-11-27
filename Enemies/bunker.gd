extends Enemy
@export var slowEffect = 10
@export var armour = 50

func _prep() -> void:
	print("bunker spawned")

func _fire_attack() -> void:
	if targetBody != null:
		pass
		#targetBody.take_damage(attack)
		#targetBody.slowDebuff(slowEffect)

func _take_damage(damage: int) -> void :
	hp -= damage * (armour/100+armour)
