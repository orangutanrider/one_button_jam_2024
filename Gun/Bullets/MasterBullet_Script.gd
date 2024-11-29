extends CharacterBody2D
class_name MasterBullet
signal BulletFired
@export var CoolDown : float = 1

## Note: All childs of master bullet cannot use the _enter_tree or _fire function because it will overwrite the processes of the master bullet
## Note 2: All processes of children should only start after BulletFired is called, including collision!

func _enter_tree() -> void:
	self.hide() 
	##Hide on entering scene

func _fire(FireLocation:Vector2, FireRotation:float) -> void:
	self.visible = 1
	self.position = FireLocation
	self.rotation_degrees = FireRotation
	BulletFired.emit() 
	## TP to location and make visible once fired 
	