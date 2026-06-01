class_name IdleState
extends PlayerState

func enter() -> void:
	player.sprite.play("Idle")
	
func handle_input(event: InputEvent):
	if not event is InputEventScreenTouch:
		return
		
	if event.pressed: 
		player.startSwipe = event.position
		return
	
	var swipe = event.position - player.startSwipe
	
	if swipe.length() < player.minimunDrag:
		stateMachine.change_state(AttackState.new(player, stateMachine, 0))
		
	elif abs(swipe.x) > abs(swipe.y):
		player.facing = sign(swipe.x)
		player.velocity.x = player.DASH_VELOCITY * sign(swipe.x)
		stateMachine.change_state(DashState.new(player, stateMachine))
		
	elif swipe.y < 0 and player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		stateMachine.change_state(JumpState.new(player, stateMachine))
