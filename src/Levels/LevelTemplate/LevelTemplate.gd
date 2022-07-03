extends Node2D
class_name Level

export (String, FILE, "*.tscn") var next_level

onready var SpawnsMelee := $SpawnsMelee
onready var SpawnsRange := $SpawnsRange
onready var LevelUI := $LevelUI

var enemies_count := 0
var current_kills := 0

func increment_deads() -> void:
	current_kills += 1
	LevelUI.set_label_enemies(current_kills, enemies_count)


func _ready() -> void:
	var melee_count := Utils.get_enemies_count(SpawnsMelee)
	var range_count := Utils.get_enemies_count(SpawnsRange)
	enemies_count = melee_count + range_count
	LevelUI.set_label_enemies(current_kills, enemies_count)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()


func is_level_completed() -> void:
	if SpawnsMelee.get_child_count() + SpawnsRange.get_child_count() == 1:
		print('go to the next level')
		get_tree().change_scene(next_level)

