extends Resource
class_name LevelData

@export var display_name: StringName
@export var scene: PackedScene
@export var next_level: LevelData
@export var enemy_stats: PaddleStatsData
@export var enemy_textures: Array[Texture2D]
