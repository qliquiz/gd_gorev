extends "res://scripts/enemyMotion.gd"

@export_range(50.0, 400.0, 1.0) var orbit_radius: float = 150.0
@export var angular_speed: float = 1.5

var target: Node2D
var orbit_angle: float = 0.0

func _ready() -> void:
	orbit_angle = randf() * TAU
	update_orbit()


func _process(delta: float) -> void:
	orbit_angle = fposmod(orbit_angle + angular_speed * delta, TAU)
	update_orbit()


func update_orbit() -> void:
	if not is_instance_valid(target):
		return
	var radial_direction := Vector2.from_angle(orbit_angle)
	global_position = target.global_position + radial_direction * orbit_radius
	velocity = radial_direction.rotated(PI / 2) * max_speed * signf(angular_speed)
	rotation = velocity.angle()
