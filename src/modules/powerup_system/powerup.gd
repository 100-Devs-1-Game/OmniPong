class_name Powerup extends Resource

enum PowerupType { BALL, PADDLE }

## Internal identifier
@export var powerup_identifier: StringName
## Powerup display name for use in UI
@export var powerup_display_name: StringName
## Texture used for the powerup in-game
@export var powerup_frames: SpriteFrames
## Additional scene automatically instantiated on the powerup used for VFX
@export var powerup_vfx: PackedScene
## Decides if the powerup can be picked up by the Ball or Paddle
@export var powerup_type: PowerupType = PowerupType.BALL
## Effects applied on pickup
@export var powerup_effects: Array[PowerupEffect] = []


func pick_up(pickup_event: PowerupPickupEvent) -> void:
    for effect in powerup_effects:
        effect.apply_effect(pickup_event)
