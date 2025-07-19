extends Node
# autoload EventBus

# the place for all global signals
# add individual regions for modules

#region physics
signal updated_ball_position(pos: Vector2)
signal updated_ball_velocity(vel: Vector2)
signal updated_player_paddle_position(pos: Vector2)
signal updated_opponent_paddle_position(pos: Vector2)
signal updated_player_paddle_rotation(rot: float)
signal updated_opponent_paddle_rotation(rot: float)
#endregion
