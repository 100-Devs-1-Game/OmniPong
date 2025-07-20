extends Node2D

@export var initial_ball_velocity := Vector2(-200, 0)

@onready var paddle: Paddle = $Paddle
@onready var ball: Ball = $Ball


func _ready() -> void:
    paddle.is_player = true
    ball.velocity = initial_ball_velocity
