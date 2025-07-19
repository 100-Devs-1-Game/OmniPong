class_name Paddle
extends Node2D

@export var max_move_speed: float = 100.0
@export var max_rotation_speed: float = 100.0

var current_direction: float


func _ready():
	# TODO wait for signal name
	#EventBus.player_move_input.connect(on_move)
	#EventBus.player_rotation_input.connect(on_rotate)
	pass


func on_move(direction: float):
	current_direction = direction


func on_look_at(towards: Vector2):
	look_at(towards)


func _physics_process(delta: float) -> void:
	position.y += current_direction * max_move_speed * delta
