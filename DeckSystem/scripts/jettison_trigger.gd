extends Area2D

# It is expected to automatically filter detections via layermasks
func area_entered(area: Area2D):
	area.jettison()
