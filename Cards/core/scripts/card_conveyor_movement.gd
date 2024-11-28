# Handles the movement of the card along the belt and up the discard-duct

extends Node2D

var active: bool = false
var velocity = Vector2.ZERO
var collideSpeedMultiplier = 1

var discarding = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !active:
		return

	if active:
		var motion = velocity * delta * collideSpeedMultiplier
		#var collision = move_and_collide(motion) 
		#if collision: 
		#	var other = collision.get_collider() 
		#	if other.is_in_group("cards") && other.position.x > position.x: 
		#		collideSpeedMultiplier += 1
		#else:
		#	collideSpeedMultiplier = 1
		if !discarding:
			#position.y = beltLineY
			rotation = 0 

func updateVelocity(v: int) -> void: 
	velocity = Vector2(-v, 0)
	
func updateOnBelt(state : bool) -> void:
	active = state