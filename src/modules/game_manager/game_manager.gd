class_name GameManager
extends Node2D

@export_category("Packed Scenes")
@export var ball_scene: PackedScene
@export var paddle_scene: PackedScene

@export_category("Powerups")
@export var powerup_pool: Array[Powerup] = []
@export var powerup_cooldown_duration: float = 10.0

@export var initial_ball_velocity: float = 300.0

@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size

var powerup_cooldown: float = 0.0


func _ready() -> void:
    handle_player_spawn()
    handle_opponent_spawn()
    handle_ball_spawn()


func _physics_process(delta: float) -> void:
    powerup_cooldown += delta
    if powerup_cooldown >= powerup_cooldown_duration:
        spawn_powerup()
        powerup_cooldown = 0


func spawn_powerup() -> void:
    var chosen_powerup: Powerup = powerup_pool.pick_random()
    var powerup_pickup_area := PowerupPickupArea2D.new(chosen_powerup)
    var screen_rect := get_viewport().get_visible_rect()
    var viable_rect := screen_rect.grow(-100)
    powerup_pickup_area.position = (
        viable_rect.position
        + Vector2(randf_range(0, viable_rect.size.x), randf_range(0, viable_rect.size.y))
    )
    self.add_child(powerup_pickup_area)


func handle_opponent_spawn():
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
    EventBus.set_ball_velocity.emit(Vector2(-1, 0) * initial_ball_velocity)
