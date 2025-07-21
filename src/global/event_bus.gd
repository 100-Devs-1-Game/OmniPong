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

signal ui_set_healthbar(left: float, right: float)
@warning_ignore("UNUSED_SIGNAL")
signal ui_hide_healthbar
@warning_ignore("UNUSED_SIGNAL")
signal ui_show_healthbar
#endregion

#region main_menu
@warning_ignore("UNUSED_SIGNAL")
signal main_menu_start
@warning_ignore("UNUSED_SIGNAL")
signal main_menu_any_button_hover
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

#region stats
#TODO: I have no idea, whatever works, replace this with whatever other people are making
signal paddle_hp_changed(is_player: bool, hp: float)
signal set_paddle_stats(is_player: bool, stats: PaddleStatsData)
#endregion stats

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
signal ball_collision_paddle
@warning_ignore("UNUSED_SIGNAL")
signal ball_collision_wall
@warning_ignore("UNUSED_SIGNAL")
signal ball_exited_screen(right_side: bool, speed: float)

@warning_ignore("UNUSED_SIGNAL")
signal set_paddle_size(is_player: bool, size: float)
@warning_ignore("UNUSED_SIGNAL")
signal change_paddle_size(is_player: bool, size_delta: float)
@warning_ignore("UNUSED_SIGNAL")
signal set_ball_size(size: float)
@warning_ignore("UNUSED_SIGNAL")
signal change_ball_size(size_delta: float)
@warning_ignore("UNUSED_SIGNAL")
signal set_paddle_speed(is_player: bool, speed: float)
@warning_ignore("UNUSED_SIGNAL")
signal change_paddle_speed(is_player: bool, speed_delta: float)
@warning_ignore("UNUSED_SIGNAL")
signal change_ball_speed_factor(factor: float)
@warning_ignore("UNUSED_SIGNAL")
signal set_paddle_rotation_speed(is_player: bool, rotation_speed: float)
@warning_ignore("UNUSED_SIGNAL")
signal change_paddle_rotation_speed(is_player: bool, rotation_speed_delta: float)
@warning_ignore("UNUSED_SIGNAL")
signal lock_paddle_rotation_speed(is_player: bool, lock: bool)

signal set_paddle_hit_strength_multiplier(is_player: bool, multiplier: float)  # affects how fast the ball moves when hit by this specific paddle
signal set_paddle_movement_speed_multiplier(is_player: bool, multiplier: float)
signal set_paddle_rotation_speed_multiplier(is_player: bool, multiplier: float)
signal set_paddle_size_multiplier(is_player: bool, multiplier: float)
signal set_paddle_texture(is_player: bool, texture: Texture2D)

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
@warning_ignore("UNUSED_SIGNAL")
signal set_paddle_texture(is_player: bool, texture: Texture2D)
#endregion
