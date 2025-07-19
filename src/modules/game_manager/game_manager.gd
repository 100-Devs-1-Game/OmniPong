class_name GameManager
extends Node2D

@export var ball_scene: PackedScene
@export var paddle_scene: PackedScene

@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size


func _ready() -> void:
	handle_player_spawn()
	handle_opponent_spawn()
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
	var left_middle_of_screen: Vector2 = Vector2(0, viewport_size.y / 2)
	player_paddle.position = left_middle_of_screen
	EventBus.set_paddle_facing_right.emit(true, true)


func handle_ball_spawn():
	var ball: Node = ball_scene.instantiate()
	self.add_child(ball)
	ball.position = get_viewport_rect().size / 2
