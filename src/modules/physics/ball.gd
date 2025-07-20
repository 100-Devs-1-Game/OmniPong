class_name Ball
extends CharacterBody2D

@export var wall_margin: float = 50.0


func _physics_process(delta: float) -> void:
    var motion: Vector2 = velocity * delta
    var new_position = position + motion

    if motion.y < 0 and new_position.y < wall_margin:
        velocity = velocity.bounce(Vector2.DOWN)
    if motion.y > 0 and new_position.y > get_viewport().get_visible_rect().size.y + wall_margin:
        velocity = velocity.bounce(Vector2.UP)

    var collision := move_and_collide(motion)

    if collision:
        velocity = velocity.bounce(collision.get_normal())

    EventBus.updated_ball_velocity.emit(velocity)
    EventBus.updated_ball_position.emit(position)
