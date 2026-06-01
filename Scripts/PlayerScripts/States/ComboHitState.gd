class_name ComboHitState
extends PlayerState

var direction: float
var accomulatedKnockback: float
var releaseSignal: Signal

func _init(p: Player, sm: StateMachine, kb: float, dir: float, release: Signal) -> void:
	super._init(p, sm)
	accomulatedKnockback = kb
	direction = dir
	releaseSignal = release

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.sprite.play("Hit")
	releaseSignal.connect(_on_released)

func exit() -> void:
	if releaseSignal.is_connected(_on_released):
		releaseSignal.disconnect(_on_released)

func _on_released(final_kb: float, dir: float) -> void:
	player.velocity = Vector2(final_kb * dir, -300)
	stateMachine.change_state(HitState.new(player, stateMachine, 0.0, dir))
