extends RichTextLabel

@export var relay: NodeReferenceRelayRes

func _process(_delta: float):
	var amount: int = relay.get_ref().read()
	text = str(amount)
