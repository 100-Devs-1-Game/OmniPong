class_name PowerupPickupEvent extends RefCounted

## Event passed to powerups upon being picked up.

## The entity that picked up the powerup (Usually Ball or Paddle)
var entity: Node


func _init(p_entity: Node) -> void:
    entity = p_entity
