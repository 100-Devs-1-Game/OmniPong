extends Node2D

@onready var paddle: Paddle = $Paddle


func _ready() -> void:
    paddle.is_player = true
