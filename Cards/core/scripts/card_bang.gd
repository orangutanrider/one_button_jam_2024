extends Area2D

@export var params: CardBangRes
var execution_delay_timer: float = 0.0
var armed_bang: bool = false

signal armed
signal played
signal jettisoned
signal discarded

func play():
	armed.emit()
	execution_delay_timer = params.execution_delay

func jettison():
	jettisoned.emit()
	pass

func discard():
	discarded.emit()
	pass

func _process(delta: float):
	if !armed_bang:
		return
	
	if execution_delay_timer <= 0.0: 
		played.emit()
		armed_bang = false
		return
	execution_delay_timer = execution_delay_timer - delta

func ghost():
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

func un_ghost():
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

# todo: animate card to disappear before it is played
