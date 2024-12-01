extends Area2D

signal armed
signal jettisoned
signal discarded

var grease_cost: int = 0

var armed_latch: bool = false

func set_grease_cost(val: int): 
	grease_cost = val

func read_grease_cost() -> int:
	return grease_cost

func arm():
	if armed_latch: return
	
	armed_latch = true
	armed.emit()

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
