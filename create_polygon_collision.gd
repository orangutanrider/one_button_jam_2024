extends Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var static_collision_shape = CollisionPolygon2D.new()
	static_collision_shape.polygon = polygon
	$StaticBody2D.add_child(static_collision_shape)
	var area_collision_shape = CollisionPolygon2D.new()
	area_collision_shape.polygon = polygon
	$Area2D.add_child(area_collision_shape)
	pass # Replace with function body.
