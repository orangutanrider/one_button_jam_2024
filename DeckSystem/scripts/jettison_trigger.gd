extends Area2D

# It is expected to automatically filter detections via layermasks
func _on_area_entered(area: Area2D):
	area.jettison()
