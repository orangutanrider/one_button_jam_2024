extends Line2D

@export var node_2: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	points[1] = node_2.position
