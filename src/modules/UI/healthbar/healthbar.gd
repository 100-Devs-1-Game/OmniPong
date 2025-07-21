extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    EventBus.connect("ui_set_healthbar", Callable(self, "ui_set_healthbar"))
    EventBus.connect("ui_hide_healthbar", Callable(self, "ui_hide_healthbar"))
    EventBus.connect("ui_show_healthbar", Callable(self, "ui_show_healthbar"))


func ui_hide_healthbar() -> void:
    self.hide()


func ui_show_healthbar() -> void:
    self.show()


func ui_set_healthbar(left: float, right: float) -> void:
    _update_healthbar_value(left, right)


func _update_healthbar_value(left: float, right: float) -> void:
    ($Left as TextureProgressBar).value = left
    ($Right as TextureProgressBar).value = right
