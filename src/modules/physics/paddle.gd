class_name Paddle
extends Node2D

@export var max_move_speed: float = 300.0
@export var max_rotation_speed: float = 100.0

@onready var screen_size = get_viewport_rect().size
var current_direction: float


func _ready():
	# TODO wait for signal name
	#EventBus.player_move_input.connect(on_move)
	#EventBus.player_rotation_input.connect(on_rotate)
	pass


func on_move(direction: float):
	print("move")
	current_direction = direction


func on_look_at(towards: Vector2):
	look_at(towards)


func _physics_process(delta: float) -> void:
	position.y += current_direction * max_move_speed * delta


func _process(delta):
	if is_in_group("player_paddle"):
		var direction := 0.0
		if Input.is_key_pressed(KEY_W):
			direction -= 1.0
		if Input.is_key_pressed(KEY_S):
			direction += 1.0
		position.y += direction * max_move_speed * delta
	position.y = clamp(position.y, 0, screen_size.y)
