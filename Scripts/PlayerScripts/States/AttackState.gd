class_name AttackState
extends PlayerState

const COMBO_WINDOW: float = 0.25

var step: int
var comboWindowTimer: float = 0.0
var isInputBuffered: bool = false
var animDone: bool = false

func _init(p: Player, sm: StateMachine, st: int) -> void:
	super._init(p, sm)
	step = st

func enter() -> void:
	var data = player.stats.comboData[step]
	print("Entering attack: ", data["anim"])
	player.sprite.play(data["anim"])
	player.hitbox.damage = data["damage"]
	player.hitbox.knockback = data["knockback"]
	player.hitbox.set_direction(player.facing)
	player.hitbox.set_active(true)
	player.sprite.animation_finished.connect(_on_anim_finished, CONNECT_ONE_SHOT)

func physics_process(_delta: float) -> void:
	if not animDone:
		return
	comboWindowTimer -= _delta
	if comboWindowTimer <= 0.0:
		stateMachine.change_state(IdleState.new(player, stateMachine))

func handle_input(_event: InputEvent) -> void:
	if _event is not InputEventScreenTouch or _event.pressed:
		return
	var swipe = _event.position - player.startSwipe
	if swipe.length() < player.minimunDrag:
		if animDone:
			_try_advance()
		else:
			isInputBuffered = true

func exit() -> void:
	player.hitbox.set_active(false)
	if player.sprite.animation_finished.is_connected(_on_anim_finished):
		player.sprite.animation_finished.disconnect(_on_anim_finished)

func _on_anim_finished() -> void:
	player.hitbox.set_active(false)
	animDone = true
	comboWindowTimer = COMBO_WINDOW
	
	if isInputBuffered:
		_try_advance()

func _try_advance() -> void:
	var maxSteps = player.stats.comboData.size() - 1 
	if step < maxSteps:
		stateMachine.change_state(AttackState.new(player, stateMachine, step + 1))
	else:
		stateMachine.change_state(IdleState.new(player, stateMachine))
