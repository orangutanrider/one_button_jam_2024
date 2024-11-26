extends Node

@export var params: CardPileRes

var count: int = 0

func count() -> int:
    return count

func check_draw() -> bool:
    if count - 1 < 0:
        return false
    else:
        return true

## use check_draw() before using this function
## It is expected that the caller will take the card out of this node's hierarchy
## It is also expected that the caller will be the one to ghost or un-ghost the card
func draw_card() -> Node:
    # you might be able to use get_child here instead
    var card: Node = find_child("card-" + str(count), false, true) 
    count = count - 1
    return card

func add_ontop(card: Node):
    count = count + 1
    card.make_ghost()
    card.name = "card-" + str(count)
    add_child(card)