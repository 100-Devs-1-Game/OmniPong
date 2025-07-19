class_name Paddle
extends Node2D

@export var paddle_controller_script: Script

@export var max_move_speed: float = 100.0
@export var max_rotation_speed: float = 100.0
@export var acceleration: float = 100.0

var controller: PaddleController
var velocity: float

var is_player := false:
	set(b):
		assert(is_inside_tree())
		is_player = b
		if is_player:
			initialize_player_controller(InputPaddleController.ControlScheme.KEYBOARD_AND_MOUSE)


func _physics_process(delta: float) -> void:
	velocity = move_toward(
		velocity, controller.get_vertical_input() * get_current_speed(), acceleration * delta
	)
	position.y += velocity * delta
	var look_vec := controller.get_look_vector(position)

	look_at(position + look_vec)


func get_current_speed() -> float:
	return max_move_speed


func initialize_player_controller(scheme: InputPaddleController.ControlScheme):
	var node = Node.new()
	node.set_script(paddle_controller_script)
	add_child(node)
	controller = node as InputPaddleController
	controller.control_scheme = InputPaddleController.ControlScheme.KEYBOARD_AND_MOUSE
