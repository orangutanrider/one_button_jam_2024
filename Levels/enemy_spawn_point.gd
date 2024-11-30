extends Node2D
@onready var area = $Area2D
@export var crawlerN = 10
@export var flyerN = 10
@export var bunkerN = 2
@export var bomberN = 4

var crawler_scene: PackedScene = preload("res://Enemies/crawler.tscn")
var flyer_scene: PackedScene = preload("res://Enemies/flyer.tscn")
var bunker_scene: PackedScene = preload("res://Enemies/bunker.tscn")
var bomber_scene: PackedScene = preload("res://Enemies/bomber.tscn")
var enemies: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemy")
	enemies = [ 
	{"count": crawlerN, "scene": crawler_scene},
	{"count": flyerN, "scene": flyer_scene}, 
	{"count": bunkerN, "scene": bunker_scene}, 
	{"count": bomberN, "scene": bomber_scene} 
	]
	area.connect("area_shape_entered",_on_area2d_area_shape_entered)

func _on_area2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if !area.get_parent().is_in_group("enemy"):
		call_deferred("_spawn_enemies")
		self.queue_free()


func _spawn_enemies():
	for enemy in enemies:
		for i in range(enemy["count"]): 
			var instance = enemy["scene"].instantiate() 
			instance.position = global_position + Vector2(randf() * 1024, -randf() * 768)
			get_tree().root.get_child(0).add_child(instance)
