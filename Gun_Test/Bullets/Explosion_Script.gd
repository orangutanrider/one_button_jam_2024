extends Node2D


func _ready() -> void:
	$GetEnemies.start()
	#The explosion has to be delayed by 1 frame as it thinks its at 0,0 if you do the explosion in _ready()


func _on_despawn_timer_timeout() -> void:
	print(self.transform)
	queue_free()

func _on_get_enemies_timeout() -> void:
	var space_state = get_world_2d().direct_space_state
	
	#Create circle shape params
	var circle = CircleShape2D.new()
	circle.radius = 50
	
	#Circle cast Query params
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = circle
	query.collision_mask = (1 << 0) | (1 << 1)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	query.margin = 0 #Explosion Radius
	query.transform = Transform2D(0,self.position)
	print(query.transform)
	
	#Perform Circle Cast
	var result = space_state.intersect_shape(query)
	
	#Process Circle Cast (Deal explosion damage)
	print(result)
	const Damage = 300

	for item in result:
		var hitobj = item.collider
		if hitobj.collision_layer & (1<<1):
			hitobj.get_parent()._take_damage(Damage)

	$DespawnTimer.start() # start Despawn Timer
