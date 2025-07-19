class_name AIPaddleController extends PaddleController

var current_ball_pos: Vector2
var current_ball_vel: Vector2

var current_ai_paddle_pos: Vector2
var current_ai_paddle_rot: float


func _ready():
    EventBus.updated_ball_position.connect(on_ball_position_update)
    EventBus.updated_ball_velocity.connect(on_ball_velocity_update)
    EventBus.updated_opponent_paddle_position.connect(on_ai_paddle_position_update)
    EventBus.updated_opponent_paddle_rotation.connect(on_ai_paddle_rotation_update)


func on_ball_position_update(pos: Vector2):
    current_ball_pos = pos


func on_ball_velocity_update(vel: Vector2):
    current_ball_vel = vel


func on_ai_paddle_position_update(pos: Vector2):
    current_ai_paddle_pos = pos


func on_ai_paddle_rotation_update(rot: float):
    current_ai_paddle_rot = rot


func get_movement_direction() -> float:
    var pos_difference: Vector2 = current_ai_paddle_pos - current_ball_pos
    var unit_distance: float = pos_difference.y / current_ball_vel.y
    if unit_distance < 0:
        return 0.0
    var target_x: float = current_ball_pos.x + current_ball_vel.x * unit_distance
    return sign(target_x - current_ai_paddle_pos.x)


func get_tilt_direction() -> float:
    return 0.0


func get_look_target() -> Vector2:
    return current_ball_pos
