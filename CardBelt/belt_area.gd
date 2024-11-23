extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var parent = area.get_parent()
	print(parent.name)
	if parent.is_in_group("cards"):
		print(parent.name)
		parent._updateVelocity(100)


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent.is_in_group("cards"):
		parent._updateVelocity(0)
