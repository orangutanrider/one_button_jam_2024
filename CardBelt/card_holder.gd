extends RigidBody2D

var itemName = ""
var type = "null"
var power = 0
var onBelt: bool = false
var velocity = Vector2.ZERO

var fallTimer = 0
const stopFallTime = 1
var resetTimer = 0
const resetTime = 3

var properties = [
	{"type": "Ammo", "name": "HE", "power": 100},
	{"type": "Ammo", "name": "AP", "power": 500},
]

func _ready() -> void: 
	var randomProperty = properties[randi() % properties.size()]
	apply_properties(randomProperty)
	gravity_scale = 0
	

func apply_properties(property): 
	self.itemName = property.name
	self.type = property.type
	self.power = property.power


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if onBelt:
		var motion = velocity * delta 
		move_and_collide(motion)
	
	if gravity_scale > 0 || gravity_scale < 0:
		fallTimer += delta
		
	if fallTimer > stopFallTime: 
		gravity_scale = 0
		resetTimer +=delta
		if resetTimer > resetTime:
			fallTimer = 0
			resetTimer = 0
			position = Vector2(526, 55)


func activate() -> void:
	print("item used")
	send_to_discard()


func send_to_discard() -> void:
	gravity_scale = -1


func updateVelocity(v: int) -> void: 
	velocity = Vector2(-v, 0)
	
func updateOnBelt(state : bool) -> void:
	onBelt = state
