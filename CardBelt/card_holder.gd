extends RigidBody2D

var item_name = ""
var type = "null"
var power = 0
var on_belt: bool = false
var velocity = Vector2.ZERO

var properties = [
	{"type": "Ammo", "name": "HE", "power": 100},
	{"type": "Ammo", "name": "AP", "power": 500},
]

func _ready() -> void: 
	var random_property = properties[randi() % properties.size()]
	apply_properties(random_property)
	gravity_scale = 0
	

func apply_properties(property): 
	self.item_name = property.name
	self.type = property.type
	self.power = property.power

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var motion = velocity * delta 
	move_and_collide(motion)

func _loadItem() -> int:
	return power
		
func _updateVelocity(v: int) -> void: 
	velocity = Vector2(-v, 0)
