extends Node2D

@export var params: CameraRes

@export var tank: Node2D
@export var camera_stick: Node2D

func _process(_delta: float) -> void:
	var target_y: float = camera_stick.global_position.y + params.swivel_y_offset
	target_y = clampf(target_y, tank.global_position.y + params.swivel_y_range_min, tank.global_position.y + params.swivel_y_range_max)
	
	position.y = target_y
	position.x = camera_stick.global_position.x
