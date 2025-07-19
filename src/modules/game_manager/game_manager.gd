class_name GameManager
extends Node2D

@export var ball_scene: PackedScene
@export var paddle_scene: PackedScene
@export var score_scene: PackedScene
@export var paddle_controller: PackedScene

@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size

var r: int = 0
var l: int = 0
var ball: Node = null


func _ready() -> void:
	EventBus.player_scored.connect(if_scored)
	handle_player_spawn()
	handle_opponent_spawn()
	handle_ball_spawn()
	handle_score_spawn()
	EventBus.ui_show_score.emit()


func if_scored(player_scored: bool) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	if player_scored:
		l += 1
	else:
		r += 1
	EventBus.emit_signal("ui_set_score", l, r, mouse_pos)
	handle_ball_spawn()


func handle_opponent_spawn():
	var opponent_paddle: Node = paddle_scene.instantiate()
	self.add_child(opponent_paddle)
	var right_middle_of_screen: Vector2 = Vector2(viewport_size.x, viewport_size.y / 2)
	opponent_paddle.position = right_middle_of_screen
	opponent_paddle.rotation_degrees = 180
	EventBus.set_paddle_facing_right.emit(false, false)


func handle_player_spawn():
	var player_paddle: Node = paddle_scene.instantiate()
	self.add_child(player_paddle)
	player_paddle.add_to_group("player_paddle")
	var left_middle_of_screen: Vector2 = Vector2(0, viewport_size.y / 2)
	player_paddle.position = left_middle_of_screen
	EventBus.set_paddle_facing_right.emit(true, true)


func handle_ball_spawn():
	var ball = ball_scene.instantiate()
	self.add_child(ball)
	ball.position = get_viewport_rect().size / 2
	var velocity = get_random_direction(600)
	EventBus.set_ball_velocity.emit(velocity)


func handle_score_spawn():
	var score: Node = score_scene.instantiate()
	self.add_child(score)
	EventBus.ui_show_score.emit()


func get_random_direction(speed: float) -> Vector2:
	var angle = randf_range(0, TAU)
	var direction = Vector2(cos(angle), sin(angle)).normalized()
	return direction * speed
