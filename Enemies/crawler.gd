extends Enemy
@export var speed = 5
var speedMultiplier = 1000
@export var kiteDistance = 1000
@export var chase_distance = 10000
@onready var spriteAnimator = $AnimatedSprite2D
var stopToAttack : bool = false
var stopTimer : float = 0
var stopDuration : float = 1

func _prep() -> void:
	print("crawler spawned")

func _action_updates(delta: float):
	_kite_away(delta)
	if stopToAttack:
		velocity.x = 0
		stopTimer += delta
		if stopTimer > stopDuration:
			stopToAttack = false
			stopTimer = 0
	

func _attack_extention() -> void:
	spriteAnimator.play("attack")
	stopToAttack = true

func _kite_away(delta: float) -> void: 
	if !(targetBody != null && !stopToAttack):
		return

	var dist = abs(global_position.x - targetBody.global_position.x)

	if dist > kiteDistance && dist < chase_distance:
		var direction = (global_position - targetBody.global_position).normalized()
		direction.x = abs(direction.x)
		velocity.x = -(direction.x * speed * delta * speedMultiplier)
		spriteAnimator.play("walk")
		return

	if dist < kiteDistance:
		var direction = (global_position - targetBody.global_position).normalized()
		direction.x = abs(direction.x)
		velocity.x = direction.x * speed * delta * speedMultiplier
		spriteAnimator.play("walk")
	else:
		velocity.x = 0
		spriteAnimator.play("default")
