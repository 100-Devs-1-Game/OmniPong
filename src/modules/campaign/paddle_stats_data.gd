extends Resource
class_name PaddleStatsData

@export var hp_max: float = 5  # default ball damage is 1?
@export var hp_regen_persecond: float = 0  # probably just going to be 0 for everyone
@export var hit_strength_multiplier: float = 1.0  # speed and damage of ball when returned?
@export var size_multiplier: float = 1.0  #taller paddle = less chance of opponent scoring
@export var movement_speed_multiplier: float = 1.0  # faster paddle = less chance of opponent scoring
@export var rotation_speed_multiplier: float = 1.0  # rotation speed = ? mainly for player QoL?
