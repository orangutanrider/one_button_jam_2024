extends RayCast2D

@export var params: ConveyorCursorRes
@export var grease_tank: NodeReferenceRelayRes

var active_timer: float = 0.0

func _physics_process(delta: float) -> void:
	if active_timer <= 0.0:
		return
	active_timer = active_timer - delta

	if !is_colliding():
		return

	var detection: Object = get_collider()
	if detection == null:
		push_warning("Unexpected null detection")
		return

	try_play_detected_card(detection)

func try_play_detected_card(card: Object):
	print("playing card")

	var grease_tank_r: Node = grease_tank.get_ref()
	var cost: int = card.read_grease_cost()

	if !grease_tank_r.can_spend(cost):
		print("Not enough grease to play the card")
		return
	
	if !card.can_play():
		return

	grease_tank_r.try_spend_grease(cost)
	
	card.arm()
	active_timer = 0.0

## Activates the cursor to play a card underneath it
func activate_cursor() -> void:
	active_timer = params.active_time
