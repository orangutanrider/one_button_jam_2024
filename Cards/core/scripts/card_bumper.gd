# When cards touch eachother they will bump eachother along by pushing the card further down the line forward

extends Area2D

# TODO
# Make it push the other card beyond the edge of its own body
# And then-some more based on the params

func area_entered(area: Area2D):
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
