extends Node
# autoload EventBus

# the place for all global signals
# add individual regions for modules

#region UI
# Updates the score shown on the UI.
#
# This function sets the score values for both players.
# If a `global_score_position` is provided, a short animation is played starting from that position.
# This can be used to show where the score came from (e.g. the ball position).
# If `global_score_position` is `Vector2.INF`, no animation is played.
#
# @param left:int Score for the left player.
# @param right:int Score for the right player.
# @param global_score_position:Vector2 (optional) The viewport position
#        to start the score animation from. Use `Vector2.INF` to skip
#        the animation.
@warning_ignore("UNUSED_SIGNAL")
signal ui_set_score(left: int, right: int, pos: Vector2)

@warning_ignore("UNUSED_SIGNAL")
signal score_shake

@warning_ignore("UNUSED_SIGNAL")
signal score_trail_animation_start

#Hide the Score UI
@warning_ignore("UNUSED_SIGNAL")
signal ui_hide_score

#Show thr Score UI
@warning_ignore("UNUSED_SIGNAL")
signal ui_show_score

signal ui_set_healthbar(left: int, right: int)
signal ui_hide_healthbar
signal ui_show_healthbar
#endregion

#region main_menu
@warning_ignore("UNUSED_SIGNAL")
signal main_menu_play_button_clicked
@warning_ignore("UNUSED_SIGNAL")
signal main_menu_campaign_play_button_clicked
@warning_ignore("UNUSED_SIGNAL")
signal main_menu_settings_button_clicked
#endregion

#region player
@warning_ignore("UNUSED_SIGNAL")
signal player_leveled_up(new_level: float)
#endregion

#region physics
@warning_ignore("UNUSED_SIGNAL")
signal updated_ball_position(pos: Vector2)
@warning_ignore("UNUSED_SIGNAL")
signal updated_ball_velocity(vel: Vector2)
@warning_ignore("UNUSED_SIGNAL")
signal updated_player_paddle_position(pos: Vector2)
@warning_ignore("UNUSED_SIGNAL")
signal updated_opponent_paddle_position(pos: Vector2)
@warning_ignore("UNUSED_SIGNAL")
signal updated_player_paddle_rotation(rot: float)
@warning_ignore("UNUSED_SIGNAL")
signal updated_opponent_paddle_rotation(rot: float)
@warning_ignore("UNUSED_SIGNAL")
signal ball_exited_screen(right_side: bool)

signal set_paddle_size(is_player: bool, size: float)
signal change_paddle_size(is_player: bool, size_delta: float)
signal set_ball_size(size: float)
signal change_ball_size(size_delta: float)
signal set_paddle_speed(is_player: bool, speed: float)
signal change_paddle_speed(is_player: bool, speed_delta: float)
signal change_ball_speed_factor(factor: float)
signal set_paddle_rotation_speed(is_player: bool, rotation_speed: float)
signal change_paddle_rotation_speed(is_player: bool, rotation_speed_delta: float)
signal lock_paddle_rotation_speed(is_player: bool, lock: bool)
#endregion

#region gamemanager
@warning_ignore("UNUSED_SIGNAL")
signal set_ball_position(pos: Vector2)
@warning_ignore("UNUSED_SIGNAL")
signal set_ball_velocity(vel: Vector2)
#endregion

#region gamemanager
@warning_ignore("UNUSED_SIGNAL")
signal set_paddle_facing_right(player_paddle: bool, right: bool)
#endregion

#region campaign
@warning_ignore("UNUSED_SIGNAL")
signal campaign_levels_loaded
@warning_ignore("UNUSED_SIGNAL")
signal campaign_state_changed(
    data: LevelData, old: CampaignManager.CAMPAIGN_STATE, new: CampaignManager.CAMPAIGN_STATE
)
@warning_ignore("UNUSED_SIGNAL")
signal campaign_level_state_changed(
    data: LevelData, old: CampaignManager.LEVEL_STATE, new: CampaignManager.LEVEL_STATE
)
#endregion
