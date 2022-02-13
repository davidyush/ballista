extends Node

var _state: Dictionary setget set_state, get_state

func get_state() -> Dictionary:
	return _state

func set_state(val: Dictionary) -> void:
	printerr("Cannot modify the state")

func create_state() -> void:
	if not _state.empty():
		_state.clear()
	_state = {
		"current_wave": 0,
		"waves": []
	}

func add_wave(wave: Array) -> void:
	_state["waves"].push_back(wave)

func create_spawn(enemies: Array, spawn: int, delay: float) -> Dictionary:
		return {
			"enemies": enemies,
			"spawn": spawn,
			"delay": delay,
			"alive": true,
		}

func is_wave_ended(index: int) -> bool:
	for enemy in _state.waves[index]:
		if enemy.alive:
			return false
	return true

func is_level_finished() -> bool:
	return is_wave_ended(_state.waves.size() - 1)
