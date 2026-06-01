class_name CharacterStats
extends Resource

@export var maxHealth: float = 200.0

@export var dashData = {
	"damage": 20.0,
	"knockback": 100.0,
}
@export var jumpData = {
	"damage": 15.0,
	"knockback": 800.0,
}

@export var comboData: Array = [
	{ "anim": "Attack1", "damage": 10.0, "knockback": 120.0 },
	{ "anim": "Attack2", "damage": 10.0, "knockback": 150.0 },
	{ "anim": "Attack3", "damage": 10.0, "knockback": 850.0 },
]
