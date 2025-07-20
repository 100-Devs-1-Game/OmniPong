class_name Ball
extends Node2D

var velocity: Vector2


func _physics_process(delta: float) -> void:
    position += velocity * delta

    EventBus.updated_ball_velocity.emit(velocity)
    EventBus.updated_ball_position.emit(position)
