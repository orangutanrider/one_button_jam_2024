##! Handles the ghosting and un-ghosting of the card

extends Node2D

# Params
@export var params: CardRootRes
@export var grease_cost: int = 0

# External reference
@export var discard_pile: NodeReferenceRelayRes

# Internal reference
@export var bang: Node
@export var collision: Node
@export var physical: RigidBody2D
@export var conveyor_movement: Node

# internal
var execution_delay_timer: float = 0.0
var armed_bang: bool = false

signal played

# Extern
func reset_physical():
	physical.position = Vector2.ZERO

func draw_trigger():
	# todo: animation
	un_ghost()
	pass

# Node
func _process(delta: float):
	if !armed_bang:
		return
	
	if execution_delay_timer <= 0.0: 
		played.emit()
		armed_bang = false
		return
	execution_delay_timer = execution_delay_timer - delta

func _ready() -> void:
	bang.armed.connect(armed)
	bang.discarded.connect(discarded)
	bang.set_grease_cost(grease_cost)
	ghost()

# Connected functions
func armed():
	execution_delay_timer = params.execution_delay
	armed_bang = true
	collision.ghost()
	conveyor_movement.ghost()

func discarded():
	ghost()
	discard_pile.get_ref().add_ontop(self)

# Ghosting
func ghost():
	armed_bang = false
	visible = false
	bang.ghost()
	physical.ghost()

func un_ghost():
	armed_bang = false
	visible = true
	bang.un_ghost()
	collision.un_ghost()
	physical.un_ghost()
	conveyor_movement.un_ghost()
