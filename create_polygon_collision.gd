extends Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = polygon
	$StaticBody2D.add_child(collision_shape)
	pass # Replace with function body.
