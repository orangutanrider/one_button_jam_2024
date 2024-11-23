extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	velocity = Vector2(SPEED,0).rotated(rotation)
	move_and_slide()
	
