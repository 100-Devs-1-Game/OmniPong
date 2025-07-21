class_name AIPaddleController extends PaddleController

@export var random_stop_probability_per_sec: float = 0.1

var current_ball_pos: Vector2
var current_ball_vel: Vector2

var current_ai_paddle_pos: Vector2
var current_ai_paddle_rot: float

var random_stop_cooldown: Timer


func _ready():
    EventBus.updated_ball_position.connect(on_ball_position_update)
    EventBus.updated_ball_velocity.connect(on_ball_velocity_update)
    EventBus.updated_opponent_paddle_position.connect(on_ai_paddle_position_update)
    EventBus.updated_opponent_paddle_rotation.connect(on_ai_paddle_rotation_update)

    random_stop_cooldown = Timer.new()
    random_stop_cooldown.one_shot = true
    random_stop_cooldown.autostart = false
    add_child(random_stop_cooldown)


func _physics_process(delta: float) -> void:
    if randf() < random_stop_probability_per_sec * delta:
        random_stop_cooldown.start()


func on_ball_position_update(pos: Vector2):
    current_ball_pos = pos


func on_ball_velocity_update(vel: Vector2):
    current_ball_vel = vel


func on_ai_paddle_position_update(pos: Vector2):
    current_ai_paddle_pos = pos


func on_ai_paddle_rotation_update(rot: float):
    current_ai_paddle_rot = rot


func get_vertical_input() -> float:
    if not random_stop_cooldown.is_stopped():
        return 0.0

    var pos_difference: Vector2 = current_ai_paddle_pos - current_ball_pos
    var unit_distance: float = pos_difference.x / current_ball_vel.x
    if unit_distance < 0:
        return 0.0
    var target_y: float = current_ball_pos.y + current_ball_vel.y * unit_distance
    return sign(target_y - current_ai_paddle_pos.y)


func get_tilt_input() -> float:
    return 0.0


func get_look_vector(_from_position: Vector2) -> Vector2:
    return (current_ball_pos - _from_position).normalized()
