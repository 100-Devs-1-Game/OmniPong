extends PowerupEffect
class_name DebugPowerupEffect
@export var on_apply_message: String = "Hello world!"


func apply_effect(event: PowerupPickupEvent) -> void:
	print("Applied powerup effect on: ", event.entity)
	print("Apply message: ", on_apply_message)
