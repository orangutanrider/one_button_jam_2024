extends Node2D

const baseSpeed = 20
const baseAccel: float = 20
const baseDeccel = 20

var pressureMaxSpeedBonus: float = 0.0
const churnMaxSpeedBonus: float = 180  

var beltSpeed = baseSpeed

var isButtonHeld = false
var tapThreshold = 0.2 
var tapTimer = 0.0

var detectedCard = null
var beltArea
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	beltArea = $Belt/BeltArea.get_overlapping_areas()

func set_pressure_bonus(val: float):
	pressureMaxSpeedBonus = val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("BUTTON1"):
		tapTimer = 0.0
	
	if Input.is_action_pressed("BUTTON1"): 
		isButtonHeld = true
		tapTimer += delta

	if Input.is_action_just_released("BUTTON1"): 
		isButtonHeld = false
		tapTimer = 0.0
		if(tapTimer <= tapThreshold):
			_use_card()

	if !Input.is_action_pressed("BUTTON1"):
		isButtonHeld = false
		tapTimer = 0.0

	# Churn bonus speed
	var churn_bonus_max: float = 0.0
	if(tapTimer > tapThreshold):
		churn_bonus_max = churnMaxSpeedBonus

	# Calculate overall acceleration and overall maximum speed
	var maximum_speed: float = baseSpeed + churn_bonus_max + pressureMaxSpeedBonus
	var accel: float = baseAccel * delta

	# Mutually exclusive if statements below
	if accel == 0.0 && beltSpeed == maximum_speed:
		# Do nothing
		_update_card_velocity() # exit  
		return
	if beltSpeed < maximum_speed: # Accelerate
		var new_speed = beltSpeed + accel
		if new_speed >= maximum_speed:
			beltSpeed = maximum_speed 
		else:
			beltSpeed = new_speed
		_update_card_velocity() # exit
		return
	if beltSpeed > maximum_speed: # Deccelerate
		var new_speed = beltSpeed - baseDeccel
		if new_speed <= maximum_speed:
			beltSpeed = maximum_speed 
		else:
			beltSpeed = new_speed
		_update_card_velocity() # exit
		return


func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent.is_in_group("cards"):
		parent.updateOnBelt(true)


func _on_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var parent = area.get_parent()
	if parent.is_in_group("cards"):
		parent.updateOnBelt(false)
		parent.send_to_discard()


func _update_card_velocity() -> void: 
	var cards = get_tree().get_nodes_in_group("cards") 
	for card in cards: 
		card.updateVelocity(beltSpeed)


func _use_card() -> void:
	var overlapping_areas = $Belt/CursorArea.get_overlapping_areas()
	for area in overlapping_areas: 
		detectedCard = area.get_parent()
		if detectedCard.is_in_group("cards"): 
			detectedCard.updateOnBelt(false)
			detectedCard.activate()
			print("use item: ", detectedCard)
