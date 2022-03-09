extends Node2D
class_name Level

export (String, FILE, "*.tscn") var next_level

onready var spawns_melee := $SpawnsMelee
onready var spawns_range := $SpawnsRange
onready var pause_menu := $PauseMenu


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('reset'):
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed('ui_cancel'):
		get_tree().paused = true
		pause_menu.visible = true


func is_level_completed() -> void:
	if spawns_melee.get_child_count() + spawns_range.get_child_count() == 1:
		print('go to the next level')
		get_tree().change_scene(next_level)


func _on_Button_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false
