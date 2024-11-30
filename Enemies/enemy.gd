class_name Enemy
extends CharacterBody2D


@export var hp = 1
@export var attack = 1
@export var attackCooldown = 2
@export var attackDistance = 100
@export var crushDamage = 100

var attackTimer = 0
var coolDown = false
var coolDownDeviation: float
@export var CoolDownDeviationRange = 0.1
var projectile_scene: PackedScene = preload("res://Enemies/enemy_projectile.tscn")

@onready var targetBody = get_node_or_null("../TankBody")
var targetDistance = 10000

@export var scanPeriod = 5
var scanTimer = 0

@onready var hitBox = $Hitbox

var sfx: AudioStreamPlayer2D
@onready var audioManager = get_node_or_null("../AudioManager")
var deathSoundScene: PackedScene = preload("res://SFX/death_sound_player.tscn")

var main

func _prep() -> void:
	push_error("_prep() needs to be overridden in derived class")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitBox.connect("area_shape_entered", _on_hitbox_area_shape_entered)
	if has_node("GunSFX") : 
		sfx = $GunSFX
	add_to_group("enemy")
	main = get_tree().root.get_child(0)
	_prep()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _process(delta: float) -> void:
	if hp <= 0 :
		_die()

	if coolDown:
		attackTimer += delta
	elif targetDistance < attackDistance:
		_fire_attack()
		coolDown = true
	if attackTimer >= (attackCooldown + coolDownDeviation):
		coolDown = false
		attackTimer = 0
	
	scanTimer += delta
	if scanTimer >= scanPeriod + coolDownDeviation:
		scanTimer = 0
		update_target_distance()
		_deviate_scan_cooldown()
	
	_action_updates(delta)

func _action_updates(delta) -> void:
	pass

func _fire_attack() -> void:
	if targetBody != null:
		var projectile = projectile_scene.instantiate()
		projectile.position = global_position 
		projectile.targetBody = targetBody 
		main.add_child(projectile)
		if audioManager != null:
			audioManager.play_sound(sfx)

func _deviate_scan_cooldown() -> void:
	coolDownDeviation =randf_range(-CoolDownDeviationRange,CoolDownDeviationRange)


func _take_damage(damage: int) -> void :
	hp -= damage
	
func _die():
	_play_death_sound()
	self.queue_free()

func _play_death_sound() -> void:
	var deathSound
	if main.has_node("DeathSoundPlayer"):
		deathSound = main.get_node("DeathSoundPlayer")
	else:
		deathSound = deathSoundScene.instantiate()
		main.add_child(deathSound)
	deathSound.global_position = global_position
	deathSound.play()

func _on_hitbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if !area.get_parent().is_in_group("enemy"):
		_take_damage(crushDamage)

func self_destruct() -> int:
	_die()
	#TODO needs replacement with actual damage to player
	return attack
	
func update_target_distance() -> void:
	if targetBody != null:
		targetDistance = global_position.distance_to(targetBody.global_position)
	else:
		targetBody = get_node_or_null("../TankBody")
		print("targetBody is null")
