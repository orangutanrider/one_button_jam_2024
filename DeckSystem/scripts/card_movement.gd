extends RigidBody2D

var onBelt: bool = false
var velocity = Vector2.ZERO
var collideSpeedMultiplier = 1
const beltStartX = 525
const beltLineY = 50

var fallTimer = 0
const stopFallTime = 1

var discarding = false

# Being ghost means it is not active on the conveyor
# The implications of which are *todo*
var ghost: bool = false

func read_ghost() -> bool:
	return ghost

func make_ghost():
	ghost = true
	
	pass

func un_ghost():
	ghost = false
	pass

func _ready() -> void: 
	gravity_scale = 0
	angular_velocity = 0

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


func activate() -> void:
	print("item used")
	send_to_discard()


func send_to_discard() -> void:
	discarding = true
	angular_velocity = 1
	gravity_scale = -3
	rotation_degrees = 0


func updateVelocity(v: int) -> void: 
	velocity = Vector2(-v, 0)
	
func updateOnBelt(state : bool) -> void:
	onBelt = state

func onto_belt() -> void:
	fallTimer = 0
	angular_velocity = 0
	discarding = false
	position = Vector2(beltStartX, beltLineY)