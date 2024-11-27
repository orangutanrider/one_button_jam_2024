# Handles the movement of the card along the belt and up the discard-duct

extends RigidBody2D

var onBelt: bool = false
var velocity = Vector2.ZERO
var collideSpeedMultiplier = 1

var fallTimer = 0
const stopFallTime = 1
var resetTimer = 0
const resetTime = 3
var discarding = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if onBelt:
		var motion = velocity * delta * collideSpeedMultiplier
		var collision = move_and_collide(motion) 
		if collision: 
			var other = collision.get_collider() 
			if other.is_in_group("cards") && other.position.x > position.x: 
				collideSpeedMultiplier += 1
		else:
			collideSpeedMultiplier = 1
		if !discarding:
			position.y = beltLineY
			rotation = 0 
	
	if gravity_scale > 0 || gravity_scale < 0:
		fallTimer += delta

	if fallTimer > stopFallTime: 
		gravity_scale = 0
		resetTimer +=delta
		if resetTimer > resetTime:
			respawn_card()

func send_to_discard() -> void:
	discarding = true
	angular_velocity = 1
	gravity_scale = -3
	rotation_degrees = 0

func updateVelocity(v: int) -> void: 
	velocity = Vector2(-v, 0)
	
func updateOnBelt(state : bool) -> void:
	onBelt = state
	
func respawn_card() -> void:
	fallTimer = 0
	resetTimer = 0
	angular_velocity = 0
	discarding = false
	position = Vector2(beltStartX, beltLineY)
