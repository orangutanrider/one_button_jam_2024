extends Enemy
@export var directionForce = 500
@export var jumpForce = 150
@export var damping = 0.95

func _prep() -> void:
	print("bomber spawned")

func _action_updates(delta) -> void:
	velocity.x *= damping

func _chase() -> void:
	if targetBody != null:
		var direction = targetBody.global_position - global_position
		if is_on_floor(): 
			velocity.y -= jumpForce
			if direction.x > 0:
				velocity.x = directionForce
			else:
				velocity.x = -directionForce


func _fire_attack() -> void:
	if targetBody != null:
		_chase()
