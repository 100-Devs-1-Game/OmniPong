class_name PlayerDataHolder
extends Node

# Interfaces:
#
# func add_xp(number: float) -> void:
# DataWarehouse.get_player_data_holder().add_xp()

#region ------------------------ PRIVATE VARS ----------------------------------

var _data: PlayerData

#endregion

#region ======================== SET UP METHODS ================================


func _init() -> void:
    _set_up()

func _set_up() -> void:
    _data = PlayerData.new()
    # TODO think about what data should be saved


#endregion

#region ======================== PUBLIC METHODS ================================

# Place for all functions that modify data
# Try to create function for every action and don’t modify data directly

func reset() -> void:
    _init()

func add_xp(number: float) -> void:
    _data.current_level_xp += number
    _try_level_up()

func set_hp(hp: float) -> void:
    _data.hp = hp
    
func get_hp() -> float:
    return _data.hp
    
func take_damage(damage: float) -> float:
    _data.hp -= damage
    EventBus.paddle_hp_changed.emit(true, _data.hp)
    return _data.hp

#endregion

#region ======================== PRIVATE METHODS ===============================


func _try_level_up() -> void:
    const MAX_LEVEL_UP_COUNT = 10000
    var current_count = 0
    while _can_level_up():
        _level_up()
        current_count += 1
        if current_count >= MAX_LEVEL_UP_COUNT:
            assert(false, "Exp is probably glitched")
            break


func _level_up() -> void:
    _data.level += 1
    _data.current_level_xp -= _get_xp_to_level_up(_data.level)
    EventBus.played_leved_up.emit()


func _can_level_up() -> bool:
    return _data.current_level_xp <= _get_xp_to_level_up(_data.level)


func _get_xp_to_level_up(level: int) -> float:
    return level * 10

#endregion
