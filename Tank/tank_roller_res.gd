class_name TankRollerRes
extends Resource

## The distance from the roller's pivot at which the roller is no longer allowed to retract
@export var RETRACTION_POINT: float = 1.0 
@export var RETRACTION_ACCEL: float = 0.01
## The speed limit of the retraction movement
@export var RETRACTION_LIMIT: float = 2.0
## The maximum distance away from the roller's pivot at which the roller is no longer allowed to extend
@export var EXTENSION_POINT: float = 10.0
@export var EXTENSION_ACCEL: float = 0.01
## The speed limit of the extension movement
@export var EXTENSION_LIMIT: float = 2.0
