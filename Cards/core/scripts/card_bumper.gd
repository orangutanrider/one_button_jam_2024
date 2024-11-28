extends Area2D

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
