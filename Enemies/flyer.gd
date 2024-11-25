extends Enemy

@export var kiteDistance = attackDistance
@export var speed = 10

@export var flyingHeight = 1000


func _prep() -> void:
	print("flyer spawned")

func _action_updates(delta: float) -> void:
	global_position.y = -flyingHeight
		
	if targetDistance < kiteDistance:
		kite_away(delta)

func kite_away(delta: float) -> void: 
	if targetBody != null:
		var direction = global_position - targetBody.global_position
		direction = direction.normalized() 
		global_position += direction * speed * delta


	
