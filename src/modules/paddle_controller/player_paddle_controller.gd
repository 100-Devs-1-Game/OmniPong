class_name InputPaddleController
extends PaddleController

enum ControlScheme { KEYBOARD, KEYBOARD_AND_MOUSE, GAMEPAD }

@export var control_scheme: ControlScheme


func get_vertical_input() -> float:
    return (
        Input.get_action_raw_strength("paddle_move_down")
        - Input.get_action_raw_strength("paddle_move_up")
    )


func get_tilt_input() -> float:
    return (
        Input.get_action_strength("paddle_tilt_down") - Input.get_action_strength("paddle_tilt_up")
    )


func get_look_vector(from_position: Vector2) -> Vector2:
    match control_scheme:
        ControlScheme.KEYBOARD_AND_MOUSE:
            var mouse_position := get_viewport().get_mouse_position()
            return (mouse_position - from_position).normalized()
        ControlScheme.GAMEPAD:
            return Input.get_vector(
                "gamepad_look_left", "gamepad_look_right", "gamepad_look_up", "gamepad_look_down"
            )

    return Vector2.ZERO
