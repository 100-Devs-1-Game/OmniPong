extends Node2D
var r_score: int = 0
var l_score: int = 0
var hide: bool = false


func _input(event):
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_MIDDLE:
            if !hide:
                EventBus.emit_signal("ui_show_score")
            else:
                EventBus.emit_signal("ui_hide_score")
            hide = !hide
            return
        if event.button_index == MOUSE_BUTTON_LEFT:
            l_score += 1
        if event.button_index == MOUSE_BUTTON_RIGHT:
            r_score += 1
        var mouse_pos = get_viewport().get_mouse_position()
        EventBus.emit_signal("ui_set_score", l_score, r_score, mouse_pos)
