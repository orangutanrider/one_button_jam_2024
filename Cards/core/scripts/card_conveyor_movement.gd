extends RayCast2D

var speed: float = 0.0

func _physics_process(_delta: float) -> void:
	if !enabled:
		speed = 0.0
		return
	
	if !is_colliding():
		speed = 0.0
		return
	
	var detection: Object = get_collider()
	if detection == null:
		push_warning("Unexpected null detection")
		speed = 0.0
		return
	
	speed = detection.read_belt_speed()
	
func ghost():
	enabled = false

func un_ghost():
	enabled = true