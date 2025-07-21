extends Node2D
class_name Level

var campaign_manager: CampaignManager
var spawn_manager: SpawnManager

var _started: bool = false


func _enter_tree() -> void:
    campaign_manager = get_tree().get_first_node_in_group(CampaignManager.group)


func _ready():
    pass


func start(data: LevelData):
    _started = true
    spawn_manager = SpawnManager.new()
    spawn_manager.paddle_scene = preload("res://modules/physics/paddle.tscn")
    spawn_manager.ball_scene = preload("res://modules/physics/ball.tscn")
    add_child(spawn_manager)
    
    spawn_manager.spawn(data.enemy_stats)

    EventBus.set_paddle_stats.emit(false, data.enemy_stats)
    EventBus.paddle_hp_changed.connect(_on_paddle_hp_changed)

    # TODO: remove after testing
    await get_tree().create_timer(30).timeout

    EventBus.paddle_hp_changed.emit(false, 0)


func _on_paddle_hp_changed(is_player: bool, hp: float) -> void:
    if !is_player && hp <= 0:
        # TODO: nice animations/text/delay/etc
        campaign_manager.next_level()
