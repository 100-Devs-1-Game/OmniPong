extends Node
# Storage for all data_holders
# Doesn't do anything else

var enemy_data: EnemyData

#region ------------------------ PRIVATE VARS ----------------------------------

var _player_data_holder: PlayerDataHolder

#endregion

#region ======================== SET UP METHODS ================================


func _ready() -> void:
	_set_up()


func _set_up() -> void:
	_set_ready_variables()


func _set_ready_variables() -> void:
	_player_data_holder = PlayerDataHolder.new()


#endregion

#region ======================== PUBLIC METHODS ================================


func get_player_data_holder() -> PlayerDataHolder:
	assert(_player_data_holder != null, "Player data holder missing")
	return _player_data_holder

#endregion
