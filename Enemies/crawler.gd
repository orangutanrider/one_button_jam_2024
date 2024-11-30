extends Enemy
@export var speed = 5
var speedMultiplier = 1000
@export var kiteDistance = 1000

func _prep() -> void:
	print("crawler spawned")

func _action_updates(delta: float):
	_kite_away(delta)

func _kite_away(delta: float) -> void: 
	if targetBody != null:
		if abs(global_position.x - targetBody.global_position.x) < kiteDistance:
			var direction = (global_position - targetBody.global_position).normalized()
			direction.x = abs(direction.x)
			velocity.x = direction.x * speed * delta * speedMultiplier
		else:
			velocity.x = 0
