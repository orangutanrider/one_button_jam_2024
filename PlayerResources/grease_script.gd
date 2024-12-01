extends Node

@export var params: GreaseScriptRes

var grease_tank: int = 0
var income_timer: float = 0.0

func _process(delta: float) -> void:
	if grease_tank == params.max_grease:
		return

	income_timer = income_timer + delta

	if income_timer >= (1 / params.grease_income_rate):
		grease_tank = grease_tank + 1
		income_timer = 0.0

## If there was enough grease to spend then it will return true, otherwise it will return false
func try_spend_grease(amount: int) -> bool:
	if amount > grease_tank:
		return false

	grease_tank = grease_tank - amount
	return true

func can_spend(amount: int) -> bool:
	if amount > grease_tank:
		return false
	return true

func read() -> int:
	return grease_tank

# Pre-loading shells causing your grease cap to become more limited?
# I'm not sure about the mechanic so I think I will just leave it alone.
