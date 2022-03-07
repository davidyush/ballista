extends Node2D
class_name Level

onready var spawns_melee = $SpawnsMelee
onready var spawns_range = $SpawnsRange

var level_completed := false

func is_level_completed() -> bool:
	#TODO need to fix, this function runs before current removing path
	#we can make sum of all children if there is only one then level is completed
	if spawns_melee.get_child_count() == 0 and spawns_range.get_child_count() == 0:
		level_completed = true
		print('Level completed')
		return true
	print('Level ISN\'T completed')
	return false
