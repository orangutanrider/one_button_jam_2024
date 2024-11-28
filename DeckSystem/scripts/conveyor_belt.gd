extends Area2D

@export var params: ConveyorBeltRes

var engine_pressure_bonus: float = 0.0
var churning: bool = false

var belt_speed = 0.0

func _ready() -> void:
	belt_speed = params.base_speed

func set_pressure_bonus(val: float):
	engine_pressure_bonus = val

func set_churning(val: bool):
	churning = val

func read_belt_speed() -> float:
	return belt_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Churn bonus
	var churn_bonus: float = 0.0
	if churning: churn_bonus = params.churn_bonus

	# Calculate overall acceleration and overall maximum speed
	var maximum_speed: float = params.base_speed + churn_bonus + engine_pressure_bonus
	var accel: float = params.accel * delta

	# Mutually exclusive if statements below
	if accel == 0.0 && belt_speed == maximum_speed:
		# Do nothing
		return
	if belt_speed < maximum_speed: # Accelerate
		var new_speed = belt_speed + accel
		if new_speed >= maximum_speed:
			belt_speed = maximum_speed 
		else:
			belt_speed = new_speed
		return
	if belt_speed > maximum_speed: # Deccelerate
		var new_speed = belt_speed - params.deccel
		if new_speed <= maximum_speed:
			belt_speed = maximum_speed 
		else:
			belt_speed = new_speed
		return
