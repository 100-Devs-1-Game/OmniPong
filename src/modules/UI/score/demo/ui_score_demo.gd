extends Node2D
var r: int = 0
var l: int = 0
var h: bool = false


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if h:
				EventBus.emit_signal("ui_show_score")
			else:
				EventBus.emit_signal("ui_hide_score")
			h = !h
			return
		if event.button_index == MOUSE_BUTTON_LEFT:
			l += 1
		if event.button_index == MOUSE_BUTTON_RIGHT:
			r += 1
		var mouse_pos = get_viewport().get_mouse_position()
		EventBus.emit_signal("ui_set_score", l, r, mouse_pos)
