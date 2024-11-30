##! The reference enters the relay through gates in the node-space

extends Node

@export var target: Node
@export var res: NodeReferenceRelayRes

func _ready() -> void:
	res.ref_entrance(target)
	pass