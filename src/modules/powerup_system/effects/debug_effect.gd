class_name DebugPowerupEffect extends PowerupEffect

@export var on_apply_message: String = "Hello world!"


func apply_effect(event: PowerupPickupEvent) -> void:
    print("Applied powerup effect on: ", event.entity)
    print("Apply message: ", on_apply_message)
