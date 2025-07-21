extends Node

@onready var sfx_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
@onready var music_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var sfx_map = {
    # score-related
    "ui_set_healthbar": preload("res://assets/sound_fx/score_increase.wav"),
    "score_trail_animation_start": preload("res://assets/sound_fx/score_increase.wav"),
    # menu-related
    "main_menu_any_button_hover": preload("res://assets/sound_fx/ui_hover.wav"),
    "main_menu_play_button_clicked": preload("res://assets/sound_fx/ui_select.wav"),
    # arena-related
    "ball_collision_paddle": preload("res://assets/sound_fx/SOUND_000025.wav"),
    "ball_collision_wall": preload("res://assets/sound_fx/SOUND_000025.wav"),
    "ball_exited_screen": preload("res://assets/sound_fx/SOUND_000013.wav")
}

var music_map = {
    # menu-related
    "main_menu_start": preload("res://assets/music/omnipong_menu_music.mp3"),
    # game-level-related
    "main_menu_play_button_clicked": preload("res://assets/music/METROPOLIS.ogg")
}


func _ready() -> void:
    add_child(sfx_player)
    add_child(music_player)

    for event_name in sfx_map.keys():
        print("connecting " + event_name + " to sfx")
        EventBus.connect(event_name, Callable(self, "_on_sfx_event").bind(event_name))

    for event_name in music_map.keys():
        print("connecting " + event_name + " to music")
        EventBus.connect(event_name, Callable(self, "_on_music_event").bind(event_name))


func play_from_audio_map(bus_name, event_name: String) -> void:
    if bus_name == "Master":
        sfx_player.stream = sfx_map[event_name]
        sfx_player.play()
    else:  # bus_name == "BGMusic"
        music_player.stream = music_map[event_name]
        music_player.play()


func _on_sfx_event(event_name: String) -> void:
    play_from_audio_map("Master", event_name)


func _on_music_event(event_name: String) -> void:
    play_from_audio_map("BGMusic", event_name)
