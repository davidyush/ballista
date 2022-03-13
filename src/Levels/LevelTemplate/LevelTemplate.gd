extends Node2D
class_name Level

var level_timer := 0.0

export (String, FILE, "*.tscn") var next_level

onready var spawns_melee := $SpawnsMelee
onready var spawns_range := $SpawnsRange

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()

func is_level_completed() -> void:
	if spawns_melee.get_child_count() + spawns_range.get_child_count() == 1:
		print('go to the next level')
		GlobalStatistics.set_time(level_timer)
		get_tree().change_scene(next_level)


func _on_Timer_timeout() -> void:
	level_timer += 0.5
