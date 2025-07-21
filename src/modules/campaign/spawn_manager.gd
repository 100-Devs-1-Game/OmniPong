extends Node2D
class_name SpawnManager

@export var ball_scene: PackedScene
@export var paddle_scene: PackedScene

@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size

var _ball

func _ready() -> void:
    EventBus.ball_exited_screen.connect(_on_ball_exited_screen)
    
func _on_ball_exited_screen(right_side: bool, speed: float) -> void:
    _ball.queue_free()
    handle_ball_spawn()

func spawn(level_data: LevelData) -> void:
    handle_player_spawn()
    handle_opponent_spawn(level_data)
    handle_ball_spawn()

func handle_opponent_spawn(level_data: LevelData):
    DataWarehouse.enemy_data = EnemyData.new()
    DataWarehouse.enemy_data.hp = level_data.enemy_stats.hp_max
    DataWarehouse.enemy_data.max_hp = level_data.enemy_stats.hp_max
    
    EventBus.set_paddle_hit_strength_multiplier.emit(false, level_data.enemy_stats.hit_strength_multiplier)
    EventBus.set_paddle_movement_speed_multiplier.emit(false, level_data.enemy_stats.movement_speed_multiplier)
    EventBus.set_paddle_size_multiplier.emit(false, level_data.enemy_stats.size_multiplier)
    EventBus.set_paddle_rotation_speed_multiplier.emit(false, level_data.enemy_stats.rotation_speed_multiplier)
    if !level_data.enemy_textures.is_empty():
        EventBus.set_paddle_texture.emit(false, level_data.enemy_textures[0])
    
    var opponent_paddle: Node = paddle_scene.instantiate()
    self.add_child(opponent_paddle)
    opponent_paddle.paddle_controller_script = load("res://modules/AI/ai_paddle_controller.gd")
    opponent_paddle.is_player = false
    var right_middle_of_screen: Vector2 = Vector2(viewport_size.x, viewport_size.y / 2)
    opponent_paddle.position = right_middle_of_screen
    opponent_paddle.rotation_degrees = 180
    EventBus.set_paddle_facing_right.emit(false, false)


func handle_player_spawn():
    var player_paddle: Node = paddle_scene.instantiate()
    self.add_child(player_paddle)
    player_paddle.paddle_controller_script = load(
        "res://modules/paddle_controller/player_paddle_controller.gd"
    )

    player_paddle.is_player = true
    var left_middle_of_screen: Vector2 = Vector2(0, viewport_size.y / 2)
    player_paddle.position = left_middle_of_screen
    EventBus.set_paddle_facing_right.emit(true, true)


func handle_ball_spawn():
    var ball: Node = ball_scene.instantiate()
    self.add_child(ball)
    EventBus.set_ball_position.emit(get_viewport_rect().size / 2)
    EventBus.set_ball_velocity.emit(Vector2(-1, 0) * 200)
    _ball = ball
