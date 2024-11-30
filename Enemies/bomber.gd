extends Enemy
@export var directionForce = 500
@export var jumpForce = 300
@export var damping = 0.98
@export var explosionRadius = 150

func _prep() -> void:
	print("bomber spawned")

func _action_updates(delta) -> void:
	if is_on_floor():
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("hop")
		
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
		update_target_distance()
		if targetDistance <= explosionRadius:
			self.queue_free()
