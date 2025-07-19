class_name Ball
extends CharacterBody2D




func _ready() -> void:
	EventBus.set_ball_velocity.connect(_set_ball_velocity)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

	var screen_size = get_viewport_rect().size

	if position.y <= 0 or position.y >= screen_size.y:
		velocity.y *= -1
		position.y = clamp(position.y, 0, screen_size.y)
		
	if position.x <= 0:
		EventBus.emit_signal("player_scored", false)
		queue_free()
		return
	elif position.x >= screen_size.x:
		EventBus.emit_signal("player_scored", true)
		queue_free()
	return

	EventBus.updated_ball_velocity.emit(velocity)
	EventBus.updated_ball_position.emit(position)


func _set_ball_velocity(vel: Vector2):
	velocity = vel
