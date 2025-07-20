extends Node2D

@onready var paddle: Paddle = $Paddle
@onready var ball: Ball = $Ball


func _ready() -> void:
    paddle.is_player = true
    ball.velocity= Vector2(-100, 0)
