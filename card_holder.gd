extends Node2D

var on_belt: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_belt:
		position.x -= 10 * delta 
		

func _loadItem() -> void:
	pass


func _on_belt_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent == self:
		on_belt = true
		print("okay")

func _on_belt_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent == self:
		on_belt = false
