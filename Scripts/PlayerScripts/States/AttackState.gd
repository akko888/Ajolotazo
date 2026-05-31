class_name AttackState
extends PlayerState

func enter() -> void:
	player.sprite.play("Attack")
	player.hitbox.damage = player.stats.basicAttackData["damage"]
	player.hitbox.knockback = player.stats.basicAttackData["knockback"]
	player.hitbox.set_direction(player.facing)
	player.hitbox.set_active(true)
	player.sprite.animation_finished.connect(_on_anim_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	player.hitbox.set_active(false)
	if player.sprite.animation_finished.is_connected(_on_anim_finished):
		player.sprite.animation_finished.disconnect(_on_anim_finished)

func _on_anim_finished() -> void:
	stateMachine.change_state(IdleState.new(player, stateMachine))
