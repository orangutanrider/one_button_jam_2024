extends Resource
class_name NodeReferenceRelayRes

var ref: Node

func ref_entrance(node: Node):
	ref = node

func get_ref() -> Node:
	return ref 