extends Node2D

enum ENEMY_TYPE {MELEE, RANGE}

onready var spawns_melee = get_child(0).get_children()
onready var spawns_range = get_child(1).get_children()

func _ready() -> void:
	LevelState.create_state()
	LevelState.add_wave([
		LevelState.create_spawn([
			LevelState.create_enemy(ENEMY_TYPE.MELEE, 2.0, false),
			LevelState.create_enemy(ENEMY_TYPE.MELEE, 1.0, false)
		], 0),
		LevelState.create_spawn([
			LevelState.create_enemy(ENEMY_TYPE.MELEE, 1.0, false),
			LevelState.create_enemy(ENEMY_TYPE.MELEE, 3.0, false)
		], 1),
		LevelState.create_spawn([
			LevelState.create_enemy(ENEMY_TYPE.MELEE, 1.0, false),
		], 2)
	])
	LevelState.add_wave([
		LevelState.create_spawn([
			LevelState.create_enemy(ENEMY_TYPE.RANGE, 1.0, true),
			LevelState.create_enemy(ENEMY_TYPE.RANGE, 3.0, true),
			], 0),
		LevelState.create_spawn([
			LevelState.create_enemy(ENEMY_TYPE.RANGE, 4.0, true),
		], 1),
	])
