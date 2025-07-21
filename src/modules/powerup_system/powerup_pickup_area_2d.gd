class_name PowerupPickupArea2D extends Area2D

signal picked_up

@export var powerup_resource: Powerup
@export var collider_size: Vector2 = Vector2(25, 25)


func _init(p_powerup_resource: Powerup = null) -> void:
    powerup_resource = p_powerup_resource


func _ready() -> void:
    assert(powerup_resource, "Powerup must be set.")

    # Hardcoded collision layer 5
    set_collision_layer_value(5, true)

    # Set collision mask to be affected by either the Paddle or the Ball
    var mask := 1 if powerup_resource.powerup_type == Powerup.PowerupType.PADDLE else 2
    set_collision_mask_value(mask, true)

    body_entered.connect(func(body: Node2D): pick_up(body))

    setup_collision_shape()
    setup_visuals()


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        pick_up(self)


func setup_collision_shape() -> void:
    var collision_shape := CollisionShape2D.new()
    var rectangle_shape := RectangleShape2D.new()

    rectangle_shape.size = collider_size

    collision_shape.shape = RectangleShape2D.new()

    add_child(collision_shape)


func setup_visuals() -> void:
    if powerup_resource.powerup_vfx:
        var vfx_node: Node = powerup_resource.powerup_vfx.instantiate()
        add_child(vfx_node)

    if powerup_resource.powerup_texture:
        var sprite := Sprite2D.new()
        sprite.texture = powerup_resource.powerup_texture
        add_child(sprite)
        sprite.position = sprite.global_scale / 2.0


func pick_up(body: Node2D) -> void:
    var event := PowerupPickupEvent.new(body)
    powerup_resource.pick_up(event)
    picked_up.emit()
    queue_free()
