extends Sprite

onready var Tween := $Tween

var path := []
signal finished_path
signal end_step

func set_path(new_path: Array) -> void:
	path = new_path
	for p in path:
		Tween.interpolate_property(self, 'global_position', global_position, p, 0.5)
		Tween.start()
		yield(Tween, 'tween_completed')
		emit_signal('end_step')
	emit_signal('finished_path')
