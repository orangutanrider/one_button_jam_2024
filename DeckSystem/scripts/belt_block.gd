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

var block_id: int = 0
var cards: Array[Area2D]

# The entry of index of card at the front of the block
# Will be reset when the block becomes empty
var front_index: int = 0
# The entry of index of card at the back of the block
# Will be reset when the block becomes empty
var back_index: int = 0

func initialize_block(id: int):
	block_id = id

func bump(dist: float):
	pass # todo

func reset_block():
	front_index = 0
	back_index = 0
	