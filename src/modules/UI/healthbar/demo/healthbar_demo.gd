extends Node

var r_health: int = 100
var l_health: int = 100
var show_health: bool = true


func _input(event):
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_MIDDLE:
            if show_health:
                EventBus.emit_signal("ui_show_healthbar")
            else:
                EventBus.emit_signal("ui_hide_healthbar")
            show_health = !show_health
            return
        if event.button_index == MOUSE_BUTTON_LEFT:
            l_health -= 10
        if event.button_index == MOUSE_BUTTON_RIGHT:
            r_health -= 10
        EventBus.emit_signal("ui_set_healthbar", l_health, r_health)
