extends Node

# Params
@export var params: ConveyorBeltInputRes

# Node References
@export var conveyor_cursor: Node
@export var conveyor: Node

# Internal
var input_timer: float = 0.0
const action_name: StringName = "BUTTON1"

func play_a_card() -> void:
	conveyor_cursor.activate_cursor()
	pass

func churn() -> void:
	conveyor.set_churning(true)
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(action_name):
		input_timer = 0.0
	
	if Input.is_action_pressed(action_name): 
		input_timer += delta
		if input_timer > params.held_input_threshold:
			churn()
	else:
		conveyor.set_churning(false)

	if Input.is_action_just_released(action_name): 
		if input_timer <= params.held_input_threshold:
			play_a_card()
		input_timer = 0.0

	if !Input.is_action_pressed(action_name):
		input_timer = 0.0
