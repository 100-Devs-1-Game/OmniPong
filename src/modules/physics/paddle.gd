class_name Paddle
extends Node2D

@export var paddle_controller_script: Script

@export var move_speed: float = 100.0
@export var rotation_speed: float = 0.5
@export var acceleration: float = 100.0
@export var vertical_wall_margin: float = 100.0

@onready var sprite: Sprite2D = $Sprite2D

var controller: PaddleController
var velocity: float
var lock_rotation: bool = false

var is_player := false:
    set(b):
        assert(is_inside_tree())
        is_player = b
        if is_player:
            initialize_player_controller(InputPaddleController.ControlScheme.KEYBOARD_AND_MOUSE)
        else:
            initialize_ai_controller()


func _ready() -> void:
    EventBus.set_paddle_size.connect(on_set_paddle_size)
    EventBus.change_paddle_size.connect(on_change_paddle_size)
    EventBus.set_paddle_rotation_speed.connect(on_set_paddle_rotation_speed)
    EventBus.change_paddle_rotation_speed.connect(on_change_paddle_rotation_speed)
    EventBus.set_paddle_speed.connect(on_set_paddle_speed)
    EventBus.change_paddle_speed.connect(on_change_paddle_speed)
    EventBus.lock_paddle_rotation_speed.connect(on_lock_paddle_rotation)
    EventBus.set_paddle_texture.connect(on_set_paddle_texture)

    hide()
    show.call_deferred()


func _physics_process(delta: float) -> void:
    if not controller:
        return
    velocity = move_toward(
        velocity, controller.get_vertical_input() * get_current_speed(), acceleration * delta
    )
    var motion: float = velocity * delta
    var new_position_y: float = position.y

    if motion < 0 and new_position_y > vertical_wall_margin:
        position.y += motion
    elif (
        motion > 0
        and new_position_y < get_viewport().get_visible_rect().size.y - vertical_wall_margin
    ):
        position.y += motion

    var look_vec := controller.get_look_vector(position)

    if not lock_rotation:
        rotation = rotate_toward(rotation, look_vec.angle(), delta * rotation_speed)

    if is_player:
        EventBus.updated_player_paddle_position.emit(position)
        EventBus.updated_player_paddle_rotation.emit(rotation)
    else:
        EventBus.updated_opponent_paddle_position.emit(position)
        EventBus.updated_opponent_paddle_rotation.emit(rotation)


func get_current_speed() -> float:
    return move_speed


func initialize_player_controller(scheme: InputPaddleController.ControlScheme):
    var node = Node.new()
    node.set_script(paddle_controller_script)
    add_child(node)
    controller = node as InputPaddleController
    controller.control_scheme = scheme


func initialize_ai_controller():
    var node = Node.new()
    node.set_script(paddle_controller_script)
    add_child(node)
    controller = node


func on_set_paddle_size(player: bool, new_size: float):
    if is_player == player:
        scale.y = new_size


func on_change_paddle_size(player: bool, new_size: float):
    if is_player == player:
        scale.y += new_size


func on_set_paddle_rotation_speed(player: bool, new_speed: float):
    if is_player == player:
        rotation_speed = new_speed


func on_change_paddle_speed(player: bool, speed_delta: float):
    if is_player == player:
        move_speed += speed_delta


func on_set_paddle_speed(player: bool, new_speed: float):
    if is_player == player:
        move_speed = new_speed


func on_lock_paddle_rotation(player: bool, lock: bool):
    if is_player == player:
        lock_rotation = lock


func on_change_paddle_rotation_speed(player: bool, speed_delta: float):
    if is_player == player:
        rotation_speed += speed_delta


func on_set_paddle_texture(player: bool, texture: Texture2D):
    if is_player == player:
        sprite.texture = texture
