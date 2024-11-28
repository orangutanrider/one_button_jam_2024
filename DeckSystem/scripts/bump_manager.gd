extends Node

# PSEUDOCODE
# Bump
# Move block forward
# Enter bumping card into block
# 
# Cards individually track the block that they are a part of
# When jettisoned they leave
# When ghosted or un-ghosted they leave
# 
# Entering a card into a block
# When the card bumps it can get the block of the card it is bumping
# Add self to that block
# 
# If no block, create one

# CREATING BLOCKS
# There should probably be a fixed number allowed right?
# How do we re-use old ones?
# Well it can know when it has been depleted. That is how.
# And then we only create new ones when none are depleted.

var blocks: Array[Node]
var block_count: int = 0

# disable the bumper of the bumped
# add them to a block
# move them forward by the intersection amount
func bump(caller: Area2D, bumped: Area2D):
	pass

# Use index 
## Picks a card out from a block
## Don't call if card has a block index of -1
func exit_block(card: Area2D):
	pass

## Search through blocks that have already been spawned, to re-use empty ones
## Otherwise create a new block
## Returns the index of the block
func into_block(caller: Area2D, bumped: Area2D) -> int:
	return 0 # todo

## Creates a brand-new block
func create_a_block() -> Node:
	return null # todo