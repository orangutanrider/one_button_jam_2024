# When cards touch eachother they will bump eachother along by pushing the card further down the line forward

extends Area2D

@export var params: CardBangRes
@export var collision_shape: RectangleShape2D

func area_entered(area: Area2D):
	if area.position.x < position.x: # If the intersecting area is further to the left than this area is (then do nothing)
		return
	
	shuffle(self, area)

# The actor pushes the subject
func shuffle(subject: Area2D, actor: Area2D):
	var dist: float = absf(actor.position.x - subject.position.x)
	var intersection: float = absf(dist - collision_shape.width)

	# Move
	var new_pos: float = subject.position.x - intersection - params.bumper_push
	subject.position.x = new_pos

	# Raycast the distance of width for next area, todo

	# If hit call this function on the next area, todo

func jettison_trigger():
	monitorable = false
	monitoring = false

func un_ghost():
	monitorable = true
	monitoring = true

func ghost():
	monitorable = false
	monitoring = false
