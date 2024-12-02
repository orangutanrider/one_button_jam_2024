extends Node2D
# var TestBullet1 = load("res://Gun_Test/Bullets/BulletTypes/AP-Shell.tscn") #Debug
# var TestBullet2 = load("res://Gun_Test/Bullets/BulletTypes/HE-Shell.tscn") #Debug
var flipflop : bool = false #Debug
var mainscene
var BulletsToLoad = []
var BulletToFire

func _ready() -> void:
	mainscene = get_tree().root.get_child(0)

## Anything adding new bullets to be fired in the gun needs to use this function
func AddNewBullets(New_Bullets:Array) -> void:
	if !(New_Bullets.is_empty()):
		for New_Bullet in New_Bullets: ##Load/Spawn All Bullets (but don't fire)
			var loopholding
			loopholding = New_Bullet.instantiate()
			BulletsToLoad.append(loopholding)
			mainscene.add_child(loopholding)
		
		if ($Shoottimer.is_stopped()): ## If the timer is currently going start it to start firing the new bullets
			_startFiring()

func _startFiring() -> void:
	$Shoottimer.start(BulletsToLoad.back().CoolDown)
	BulletToFire=BulletsToLoad.back() 

func _on_shoottimer_timeout() -> void:
	##Set rotation and position of new bullet
	BulletToFire._fire($BulletEmitLocation.global_position, global_rotation)
	$AudioStreamPlayer2D.play()
	BulletsToLoad.remove_at(BulletsToLoad.find(BulletToFire))
	## Set another timer if there's more bullets or stop the timer if there's none
	if !(BulletsToLoad.is_empty()):
		_startFiring()
	else:
		$Shoottimer.stop()
		BulletToFire = null
# Debug
# func _process(delta: float) -> void:
# 	if Input.is_action_just_pressed("BUTTON1"):
# 		if flipflop:
# 			AddNewBullets([TestBullet1])
# 			flipflop = 0
# 		else:
# 			AddNewBullets([TestBullet2])
# 			flipflop = 1
