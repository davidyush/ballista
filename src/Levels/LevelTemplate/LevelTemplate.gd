extends Node2D
class_name Level

onready var spawns_melee = $SpawnsMelee
onready var spawns_range = $SpawnsRange

#do we need this var?
var level_completed := false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()

func is_level_completed() -> bool:
	# TODO need to fix, this function runs before current removing path
	# we can make sum of all children if there is only one then level is completed
	if spawns_melee.get_child_count() + spawns_range.get_child_count() == 1:
		level_completed = true
		print('go to the next level')
		return true
	print('Level ISN\'T completed')
	return false
