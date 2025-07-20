extends Control

var last_score_left: int = 0
var last_score_right: int = 0
var pos_left: Vector2
var pos_right: Vector2
var shake_left: bool = false
var shake_right: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    EventBus.connect("ui_set_score", Callable(self, "ui_set_score"))
    EventBus.connect("ui_hide_score", Callable(self, "ui_hide_score"))
    EventBus.connect("ui_show_score", Callable(self, "ui_show_score"))


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
#        to start the score animation from. Use `Vector2.INF` to skip the
#        animation.
func ui_set_score(left: int, right: int, global_score_position: Vector2 = Vector2.INF) -> void:
    var targets: Array = []
    if left != last_score_left:
        targets.append(($HBoxContainer/LeftScoreLabel/Point as Control).global_position)
        shake_left = true
    if right != last_score_right:
        targets.append(($HBoxContainer/RightScoreLabel/Point as Control).global_position)
        shake_right = true
    last_score_left = left
    last_score_right = right
    # Early return if both scores are zero (game start or reset)
    if left == 0 and right == 0:
        _update_score_labels(left, right)
        return
    # If a position was given, play an animation from that position
    if global_score_position != Vector2.INF:
        for target in targets:
            _play_score_animation(global_score_position, target, left, right)


func ui_hide_score() -> void:
    self.hide()


func ui_show_score() -> void:
    self.show()


func _update_score_labels(left: int, right: int) -> void:
    $HBoxContainer/LeftScoreLabel.text = str(left)
    $HBoxContainer/RightScoreLabel.text = str(right)


func _play_score_animation(
    from_position: Vector2, to_position: Vector2, left: int, right: int
) -> void:
    var effect_scene = preload("res://modules/ui/score/score_effect.tscn").instantiate()
    self.add_child(effect_scene)
    effect_scene.scale = self.scale
    effect_scene.left = left
    effect_scene.right = right
    effect_scene.connect("movement_finished", Callable(self, "_on_effect_done"))
    $score_sweep.play()
    # Start the movement
    effect_scene.start_movement(from_position, to_position, 0.5)


func _on_effect_done(left: int, right: int):
    _update_score_labels(left, right)
    _play_secondary_effect()


func _play_secondary_effect() -> void:
    var tween := get_tree().create_tween()
    var shake_count = 3  # number of shakes
    if shake_left or shake_right:
        $score_increase.play()
    for i in range(shake_count):
        if shake_left:
            move_by_random_offset($HBoxContainer/LeftScoreLabel, tween)
        if shake_right:
            move_by_random_offset($HBoxContainer/RightScoreLabel, tween)
    tween.play()
    shake_left = false
    shake_right = false


func randf_double_range(low1: float, high1: float, low2: float, high2: float) -> float:
    # select a random value between -30..-15 or 15..30
    # we don't want small values, because it results in a minor shake
    if randi() % 2 == 0:
        return randf_range(low1, high1)
    return randf_range(low2, high2)


func move_by_random_offset(label: Label, tween) -> void:
    var original_pos = label.position
    var duration = 0.07  # how long each shake lasts
    var offset = Vector2(randf_double_range(-30, -15, 15, 30), randf_double_range(-30, -15, 15, 30))
    (
        tween
        . tween_property(label, "position", original_pos + offset, duration)
        . set_trans(Tween.TRANS_SINE)
        . set_ease(Tween.EASE_IN_OUT)
    )
    (
        tween
        . tween_property(label, "position", original_pos, duration)
        . set_trans(Tween.TRANS_SINE)
        . set_ease(Tween.EASE_IN_OUT)
    )
