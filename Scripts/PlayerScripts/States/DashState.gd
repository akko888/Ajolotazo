class_name DashState
extends PlayerState

var COMBO_WINDOW: float = 0.25
var comboWindowTimer: float = 0.0
var dashEnded: bool = false

func enter() -> void:
	print("Dash state")
	player.hitbox.damage = player.stats.dashData["damage"]
	player.hitbox.knockback = player.stats.dashData["knockback"]
	player.hitbox.set_direction(player.facing)
	player.hitbox.set_active(true)
	player.sprite.play("Dash")

func exit() -> void:
	player.hitbox.set_active(false)
	
func physics_process(_delta: float) -> void:
	if not dashEnded:
		if abs(player.velocity.x) < 10.0 and player.is_on_floor():
			dashEnded = true
			comboWindowTimer = COMBO_WINDOW
		return
	
	comboWindowTimer -= _delta
	if comboWindowTimer <= 0.0:
		stateMachine.change_state(IdleState.new(player, stateMachine))

func handle_input(_event: InputEvent) -> void:
	if _event is not InputEventScreenTouch or _event.pressed:
		return
		
	var swipe = _event.position - player.startSwipe
		
	if swipe.length() >= player.minimunDrag:
		if abs(swipe.x) <= abs(swipe.y) and swipe.y < 0:
			player.velocity.y = player.JUMP_VELOCITY
			stateMachine.change_state(JumpState.new(player, stateMachine))
		return
		
	if dashEnded:
		stateMachine.change_state(AttackState.new(player, stateMachine, 0))
