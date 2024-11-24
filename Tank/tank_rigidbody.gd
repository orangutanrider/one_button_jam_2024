extends RigidBody2D

## Multiplies all forces
@export var FORCE_SCALAR: float = 1.0

@export var POSITIONED_UP_FORCES: Array[Node]
@export var DOWN_FORCES: Array[Node]
@export var FORWARD_FORCES: Array[Node]

var up_point: Node2D
var down_point: Node2D
var forward_point: Node2D

func _ready() -> void:
    down_point = $DownPoint
    forward_point = $ForwardPoint
    up_point = $UpPoint
    pass

func _physics_process(_delta: float) -> void:
    var up: Vector2 = (up_point.global_position - global_position).normalized()
    for node in POSITIONED_UP_FORCES: 
        var force_position: Vector2 = node.read_positioned_up_force_position()
        var force: float = node.read_positioned_up_force_strength()

        apply_force(up * FORCE_SCALAR * force, force_position)

    var down: Vector2 = (down_point.global_position - global_position).normalized()
    for node in DOWN_FORCES: 
        var force: float = node.read_down_force()

        apply_central_force(down * FORCE_SCALAR * force)

    var forward: Vector2 = (forward_point.global_position - global_position).normalized()
    for node in FORWARD_FORCES: 
        var force: float = node.read_forward_force()

        apply_central_force(forward * FORCE_SCALAR * force)