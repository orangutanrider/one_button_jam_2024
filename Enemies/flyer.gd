extends Enemy

@export var kiteDistance = 1000
@export var speed = 30
var speedMultiplier = 1000

@export var flyingHeight = 500
@export var deviateRange = 200
var deviation = Vector2(0,0)
var deviateTimer = 0
@export var deviationPeriod = 1
var groundLevel = 0
var targetHeight = 0


func _prep() -> void:
	print("flyer spawned")

func _action_updates(delta: float) -> void:
	targetHeight = groundLevel - flyingHeight + deviation.y
	velocity.y = (targetHeight - global_position.y) * speed * delta
	
	_kite_away(delta)
	if deviateTimer > deviationPeriod:
		_deviate()
		deviateTimer = 0
	else:
		deviateTimer += delta

func _kite_away(delta: float) -> void: 
	if targetBody != null:
		if abs(global_position.x - targetBody.global_position.x) < kiteDistance + deviation.x:
			var direction = (global_position - targetBody.global_position).normalized()
			groundLevel = targetBody.global_position.y
			direction.x = abs(direction.x)
			velocity.x = direction.x * speed * delta * speedMultiplier
		else:
			velocity.x = 0

func _deviate() -> void:
	deviation = Vector2(randf_range(-deviateRange,deviateRange),randf_range(-deviateRange,deviateRange))
