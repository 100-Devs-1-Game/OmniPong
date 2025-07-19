extends Control
signal movement_finished(left:int,right:int)
var left:int
var right:int
@onready var tween := get_tree().create_tween()

func start_movement(from: Vector2, to: Vector2, duration: float = 0.2) -> void:
	global_position = from
	print(from,to)
	tween.tween_property(self, "global_position", to, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.connect("finished", Callable(self, "_on_tween_finished"))

func _on_tween_finished():
	($"Particles" as GPUParticles2D).emitting = false
	emit_signal("movement_finished",left,right)
	# Wait 1 second, then queue_free this node
	await get_tree().create_timer(0.5).timeout
	queue_free()
