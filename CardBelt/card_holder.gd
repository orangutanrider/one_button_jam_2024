extends RigidBody2D

var item_name = ""
var on_belt: bool = false
var velocity = Vector2.ZERO

func _ready() -> void: 
	gravity_scale = 0
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var motion = velocity * delta 
	move_and_collide(motion)

func _loadItem() -> void:
	pass
		
func _updateVelocity(v: int) -> void: 
	velocity = Vector2(-v, 0)
