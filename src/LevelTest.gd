extends Node2D

enum ENEMY_TYPE {MELEE, RANGE}

onready var spawns_melee = get_child(0).get_children()
onready var spawns_range = get_child(1).get_children()

func _ready() -> void:
	LevelState.create_state()
	LevelState.add_wave([
		LevelState.create_spawn([ENEMY_TYPE.MELEE], 0, 2.0),
		LevelState.create_spawn([ENEMY_TYPE.RANGE], 1, 5.0)
	])
	LevelState.add_wave([
			LevelState.create_spawn([ENEMY_TYPE.RANGE], 0, 0.0),
			LevelState.create_spawn([ENEMY_TYPE.RANGE], 1, 4.0),
			LevelState.create_spawn([ENEMY_TYPE.MELEE], 1, 7.0)
	])
