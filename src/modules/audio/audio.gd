extends Node

@onready var player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var sfx_ping = preload("res://assets/sound_fx/score_increase.wav")

var audio_map = {
    # score-related
    "score_trail_animation_start": sfx_ping
    # paddle-related
    # menu-related
}


func _ready() -> void:
    add_child(player)
    for event_name in audio_map.keys():
        print("connecting " + event_name + " to sound")
        EventBus.connect(event_name, Callable(self, "_on_event").bind(event_name))


func play_from_audio_map(event_name: String) -> void:
    player.stream = audio_map[event_name]
    player.play()


func _on_event(event_name: String) -> void:
    play_from_audio_map(event_name)
