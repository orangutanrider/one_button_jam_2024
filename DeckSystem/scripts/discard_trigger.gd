extends Area2D

@export var discard_pile: Node

# It is expected to automatically filter detections via layermasks
func area_entered(_area: Area2D):
    
    pass

func add_card_to_discard(card: Node):
    card.make_ghost()
    discard_pile.add_ontop(card)
    pass