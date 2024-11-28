# When cards touch eachother they will bump eachother along by pushing the card further down the line forward

extends Area2D

@export var params: CardMovementRes
@export var collision_shape: RectangleShape2D

signal bump(movement: float)

func area_entered(area: Area2D):
	if area.position.x < position.x: # If the intersecting area is further to the left than this area is (then do nothing)
		return
	print("E")
	shuffle(area)

# The actor pushes the subject
# self is the subject
func shuffle(actor: Area2D):
	var dist: float = absf(actor.position.x - position.x)
	var intersection: float = absf(dist - collision_shape.width)

	# Move
	var motion: float = intersection + params.bumper_push
	bump.emit(motion)

func cascade():
	# Raycast the distance of width for next area, todo
	# If hit call shuffle on the next area
	pass

func jettison_trigger():
	monitorable = false
	monitoring = false

func un_ghost():
	monitorable = true
	monitoring = true

func ghost():
	monitorable = false
	monitoring = false
