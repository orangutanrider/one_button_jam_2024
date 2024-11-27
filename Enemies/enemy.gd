class_name Enemy
extends CharacterBody2D


@export var hp = 1
@export var attack = 1
@export var attackCooldown = 2
@export var attackDistance = 100
@export var crushDamage = 100

var attackTimer = 0
var coolDown = false

@onready var targetBody = get_node_or_null("../TankBody")
var targetDistance = 10000

@export var scanPeriod = 5
var scanTimer = 0


func _prep() -> void:
	push_error("_prep() needs to be overridden in derived class")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if attackTimer >= attackCooldown:
		coolDown = false
		attackTimer = 0
		
	
	scanTimer += delta
	if scanTimer >= scanPeriod:
		scanTimer = 0
		if targetBody != null:
			targetDistance = global_position.distance_to(targetBody.global_position)
		else:
			targetBody = get_node_or_null("../TankBody")
			print("targetBody is null")
	
	_action_updates(delta)

func _action_updates(delta) -> void:
	pass

func _fire_attack() -> void:
	if targetBody != null:
		pass
		#needs implementation on tank body
		#targetBody.take_damage(attack)


func _take_damage(damage: int) -> void :
	hp -= damage
	
func _die():
	self.queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if targetBody != null:
		if body.name == targetBody.name:
			_take_damage(crushDamage)
