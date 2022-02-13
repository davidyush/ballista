extends Node2D

onready var Initial := $Initial
onready var Target := $Target

export (float) var delay := 0.0
export (String, FILE, '*.tscn') var Enemy_Source

func spawn_instance() -> void:
	var instance := Utils.instance_scene_on_main(Enemy_Source, Initial.global_position)
	instance.initial_position = Initial.global_position
	instance.target_position = Target.global_position
