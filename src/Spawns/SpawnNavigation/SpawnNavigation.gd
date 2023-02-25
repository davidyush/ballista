extends Position2D

export (PackedScene) var unit = null
export (Array, float) var timers
export (int) var amount

var index = 0

func _ready() -> void:
	for i in amount:
		yield(get_tree().create_timer(timers[index]), 'timeout')
		print(index, timers[index])
		set_time_index()
		push_unit()

func set_time_index() -> void:
	if index + 1 == timers.size():
		index = 0
	else:
		index += 1

func push_unit() -> void:
	Utils.instance_scene_on_main(unit, position)
