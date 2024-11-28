extends RayCast2D

var velocity = Vector2.ZERO
var collideSpeedMultiplier = 1

var jettisoned: bool = false

func _physics_process(delta: float) -> void:
	if !enabled:
		return
	
	if !is_colliding():
		return
    
	var detection: Object = get_collider()
	if detection == null:
		push_warning("Unexpected null detection")
		return
	
	var conveyor_speed: float = detection.read_belt_speed()


func jettison_trigger():
	jettisoned = true
	
func ghost():
	enabled = false
	jettisoned = false

func un_ghost():
	enabled = true
	jettisoned = false