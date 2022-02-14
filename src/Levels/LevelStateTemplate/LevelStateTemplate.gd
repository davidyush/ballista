extends Node2D

var enemy := preload("res://src/Enemy/Enemy.tscn")

enum ENEMY_TYPE {MELEE, RANGE}

onready var spawns_melee = get_child(0).get_children()
onready var spawns_range = get_child(1).get_children()

var current_time := 0.0;

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
		], 0)
	])


func _on_Timer_timeout():
	current_time += 1.0
	var current_state = LevelState.get_state();
	for spawn in current_state.waves[current_state.current_wave]:
		spawns_melee[spawn.spawn].enemies = spawn.enemies
		
