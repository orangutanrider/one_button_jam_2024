extends Area2D

signal armed
signal jettisoned
signal discarded

var armed_latch: bool = false

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
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

func un_ghost():
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

# todo: animate card to disappear before it is played
