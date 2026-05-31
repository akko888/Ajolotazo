class_name JumpState
extends PlayerState

func enter() -> void:
	print("Jump state")
	player.hitbox.damage = player.stats.jumpData["damage"]
	player.hitbox.knockback = player.stats.jumpData["knockback"]
	player.hitbox.set_direction(player.facing)
	player.hitbox.set_active(true)
	player.sprite.play("Jump")
	
func exit() -> void:
	player.hitbox.set_active(false)
	
func physics_process(_delta: float) -> void:
	if player.is_on_floor() and player.velocity.y >= 0:
		stateMachine.change_state(LandState.new(player, stateMachine))
		
func handle_input(_event: InputEvent) -> void:
	if _event is not InputEventScreenTouch:
		return
		
	if _event.pressed:
		player.startSwipe = _event.position
		return
		
	var swipe = _event.position - player.startSwipe
	
	if swipe.length() >= player.minimunDrag:
		if abs(swipe.x) > abs(swipe.y):
			player.facing = sign(swipe.x)
			player.velocity.x = player.DASH_VELOCITY * sign(swipe.x)
			stateMachine.change_state(DashState.new(player, stateMachine))
