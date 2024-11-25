extends Node2D
var TestBullet = load("res://Gun_Test/Bullet/RegularBullet.tscn") #Debug
var mainscene
var LoadedBullets = []


func _ready() -> void:
	mainscene = get_tree().root.get_child(0)

## Anything adding new bullets to be fired in the gun needs to use this function
func AddNewBullets(New_Bullets:Array) -> void:
	if !(New_Bullets.is_empty()):
		for New_Bullet in New_Bullets: ##Load/Spawn All Bullets (but don't fire)
			var loopholding
			loopholding = New_Bullet.instantiate()
			LoadedBullets.append(loopholding)
			mainscene.add_child(loopholding)
		
		if ($Shoottimer.is_stopped()): ## If the timer is currently going start it to start firing the new bullets
			$Shoottimer.start(LoadedBullets.back().CoolDown) 
	

func _on_shoottimer_timeout() -> void:
	##Set rotation and position of new bullet
	LoadedBullets.pop_back()._fire($BulletEmitLocation.global_position, self.rotation_degrees)
	
	## Set another timer if there's more bullets or stop the timer if there's none
	if !(LoadedBullets.is_empty()):
		$Shoottimer.wait_time = LoadedBullets.back().CoolDown()
	else:
		$Shoottimer.stop()

#Debug
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("BUTTON1"):
		AddNewBullets([TestBullet])
