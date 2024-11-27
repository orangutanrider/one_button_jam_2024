# Handles the movement of the card

extends RigidBody2D

func ghost():
	sleeping = true
	freeze = true
	pass

func un_ghost():
	sleeping = false
	freeze = false
	pass