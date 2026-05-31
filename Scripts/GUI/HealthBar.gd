extends TextureProgressBar

func setup(player: Player) -> void:
	max_value = player.stats.maxHealth
	value = player.stats.maxHealth
	player.health_changed.connect(_on_health_changed)
	player.died.connect(_on_died)

func _on_health_changed(newHealth: float, maxHealth: float) -> void:
	max_value = maxHealth
	value = newHealth

func _on_died() -> void:
	value = 0
