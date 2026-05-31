class_name HitState
extends PlayerState

var knockback: float
var direction: float

func _init(p: Player, sm: StateMachine, kb: float, dir: float) -> void:
	super._init(p, sm)
	knockback = kb
	direction = dir

func enter() -> void:
	player.velocity = Vector2(knockback * direction, -150)
	player.sprite.play("Hit")
	player.sprite.animation_finished.connect(_on_hit_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	if player.sprite.animation_finished.is_connected(_on_hit_finished):
		player.sprite.animation_finished.disconnect(_on_hit_finished)

func _on_hit_finished() -> void:
	stateMachine.change_state(IdleState.new(player, stateMachine))
