extends Position2D

export (PackedScene) var unit = null
export (Array, float) var timers
export (int) var amount

var index = 0

func _ready() -> void:
	for i in amount:
		yield(get_tree().create_timer(timers[index]), 'timeout')
		set_time_index()
		push_unit()

func set_time_index() -> void:
	index = 0 if index + 1 == timers.size() else index + 1

func push_unit() -> void:
	Utils.instance_scene_on_main(unit, position)
