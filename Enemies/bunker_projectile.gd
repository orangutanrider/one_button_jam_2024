extends CharacterBody2D
@onready var targetBody = get_node_or_null("../TankBody")
@export var despawnTime = 2
@onready var despawnTimer = despawnTime
@export var acceleration = 5000.0 

func _physics_process(delta: float) -> void: 
	despawnTimer -= delta
	if despawnTimer <= 0:
		self.queue_free()
		
	if targetBody != null: 
		_home_in_on_target(delta) 
	else:
		targetBody = get_node_or_null("../TankBody")
	rotation = atan2(velocity.y,velocity.x)
	move_and_slide()
	
func _home_in_on_target(delta: float) -> void: 
	var direction = (targetBody.global_position - global_position).normalized() 
	velocity += direction * acceleration * delta


func _on_hitbox_body_entered(body: Node2D) -> void:
	if targetBody != null:
		if targetBody.name == body.name:
			self.queue_free()
