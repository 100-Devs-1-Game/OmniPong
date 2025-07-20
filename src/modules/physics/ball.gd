class_name Ball
extends CharacterBody2D

@export var wall_margin: float = 50.0
@export var angle_speed_ratio: float = 1.0


func _ready() -> void:
    EventBus.set_ball_position.connect(func(pos: Vector2): position = pos)
    EventBus.set_ball_velocity.connect(func(vel: Vector2): velocity = vel)


func _physics_process(delta: float) -> void:
    var motion: Vector2 = velocity * delta
    motion *= get_speed_ratio()

    var new_position = position + motion

    if motion.y < 0 and new_position.y < wall_margin:
        velocity = velocity.bounce(Vector2.DOWN)
    if motion.y > 0 and new_position.y > get_viewport().get_visible_rect().size.y - wall_margin:
        velocity = velocity.bounce(Vector2.UP)

    var collision := move_and_collide(motion)

    if collision:
        var normal := collision.get_normal()
        if sign(normal.x) != sign(velocity.x):
            velocity = velocity.bounce(collision.get_normal())

    EventBus.updated_ball_velocity.emit(velocity)
    EventBus.updated_ball_position.emit(position)


func get_speed_ratio() -> float:
    return 1.0 / abs(pow(Vector2.RIGHT.dot(velocity.normalized()), angle_speed_ratio))


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    EventBus.ball_exited_screen.emit(velocity.x > 0)
