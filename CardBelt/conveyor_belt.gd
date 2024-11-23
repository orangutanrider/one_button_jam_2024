extends Node2D

const baseSpeed = 20
var beltSpeed = baseSpeed
var acceleration = 15
const deceleration = 30
const maxSpeed = 100
var isButtonHeld = false
var tapThreshold = 0.2 
var tapTimer = 0.0
var detectedCard = null
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("BUTTON1"):
		tapTimer = 0.0
		
		
	if Input.is_action_pressed("BUTTON1"): 
		isButtonHeld = true
		tapTimer += delta
		if(tapTimer > tapThreshold):
			beltSpeed = min(beltSpeed + acceleration * delta, maxSpeed) 
			
			print(beltSpeed)
		
	if Input.is_action_just_released("BUTTON1"): 
		isButtonHeld = false
		if(tapTimer <= tapThreshold):
			_use_card()
			
	
	if not isButtonHeld and beltSpeed > baseSpeed: 
		beltSpeed = max(beltSpeed - deceleration * delta, baseSpeed) 
		print(beltSpeed)
	
	_update_card_velocity() 


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent.is_in_group("cards"):
		parent.updateOnBelt(true)


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent.is_in_group("cards"):
		parent.updateOnBelt(false)


func _update_card_velocity() -> void: 
	var cards = get_tree().get_nodes_in_group("cards") 
	for card in cards: 
		card.updateVelocity(beltSpeed)


#func _has_overlapping_areas() -> bool: 
	#var overlapping_areas = $Belt/CursorArea.get_overlapping_areas() 
	#return overlapping_areas.size() > 0

func _use_card() -> void:
	var overlapping_areas = $Belt/CursorArea.get_overlapping_areas()
	for area in overlapping_areas: 
		var parent = area.get_parent()
		if parent.is_in_group("cards"): 
			detectedCard = parent
			print("use item", detectedCard)
