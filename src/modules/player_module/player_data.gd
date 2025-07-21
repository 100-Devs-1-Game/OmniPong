class_name PlayerData
extends Resource

#region ------------------------ PUBLIC VARS -----------------------------------

@export var level: int = 0
@export var current_level_xp: int = 0
#TODO fill array type with powerup type
@export var permanent_powerups: Array = []
@export var stats: PaddleStatsData
@export var hp: float = 10
@export var max_hp: float = 10

#endregion
