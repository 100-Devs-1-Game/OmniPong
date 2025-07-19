extends Control

@export var game_scene: PackedScene
@export var setting_scene: PackedScene


# connect to signals for button presses
func _ready() -> void:
    $CenterContainer/VBoxContainer/PlayButton.connect("pressed", _on_play_button_down)
    $CenterContainer/VBoxContainer/SettingsButton.connect("pressed", _on_settings_button_down)


func _on_play_button_down():
    EventBus.main_menu_play_button_clicked.emit()
    print("Play button on main menu clicked")
    scene_change(game_scene)


func _on_settings_button_down():
    EventBus.main_menu_settings_button_clicked.emit()
    print("Settings button on main menu clicked")
    scene_change(setting_scene)


func scene_change(scene_to_change: PackedScene) -> void:
    if scene_to_change:
        get_tree().change_scene_to_packed(scene_to_change)
    else:
        print("Scene not set")
