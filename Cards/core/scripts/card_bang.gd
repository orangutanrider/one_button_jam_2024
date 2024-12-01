extends Area2D

signal armed
signal jettisoned
signal discarded

var grease_cost: int = 0

var armed_latch: bool = false

func can_play() -> bool:
	if armed_latch == false:
		return true
	return false

func set_grease_cost(val: int): 
	grease_cost = val

func read_grease_cost() -> int:
	return grease_cost

func arm() -> bool:
	if armed_latch: return false
	
	armed_latch = true
	armed.emit()
	return true

func jettison():
	jettisoned.emit()
	pass

func discard():
	discarded.emit()
	pass

func ghost():
	armed_latch = false
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

func un_ghost():
	armed_latch = false
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

# todo: animate card to disappear before it is played
