class_name Hitbox
extends Area2D

var damage: int = 10

func _init() -> void:
	collision_layer = 2
	collision_mask = 0
	
func _ready() -> void:
	monitorable = false

func set_active(active: bool) -> void:
	monitorable = active
	$CollisionShape2D.set_deferred("disabled", not active)

func set_direction(dir: float):
	position.x = abs(position.x) * dir
