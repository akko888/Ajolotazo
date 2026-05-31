class_name Hurtbox
extends Area2D

const HITSTOP_DURATION = 0.08

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	if hitbox.owner == owner:
		return
	
	owner.apply_hitstop(HITSTOP_DURATION)
	hitbox.owner.apply_hitstop(HITSTOP_DURATION)
	
	hitbox.owner.velocity.x *= 0.3
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage, hitbox.knockback, hitbox.facing)
