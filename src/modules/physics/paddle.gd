class_name Paddle
extends Node2D

@export var paddle_controller_script: Script

@export var max_move_speed: float = 100.0
@export var max_rotation_speed: float = 100.0
@export var acceleration: float = 100.0
@export var vertical_wall_margin: float = 100.0

var controller: PaddleController
var velocity: float

var is_player := false:
    set(b):
        assert(is_inside_tree())
        is_player = b
        if is_player:
            initialize_player_controller(InputPaddleController.ControlScheme.KEYBOARD_AND_MOUSE)
        else:
            initialize_ai_controller()


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

    look_at(position + look_vec)
    if is_player:
        EventBus.updated_player_paddle_position.emit(position)
        EventBus.updated_player_paddle_rotation.emit(look_vec)
    else:
        EventBus.updated_opponent_paddle_position.emit(position)
        EventBus.updated_opponent_paddle_rotation.emit(look_vec)


func get_current_speed() -> float:
    return max_move_speed


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
