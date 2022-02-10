extends Node2D

var EnemyMelee := preload("res://src/EnemyMelee/EnemyMelee.tscn")

onready var Spawn := $Spawn
onready var Target := $Target
onready var Timer := $Timer

# need to get the number from global state of the game
var count := 1

func instance_scene_on_spawn(scene: PackedScene, position: Vector2) -> void:
	var main := get_tree().current_scene
	var instance := scene.instance()
	main.add_child(instance)
	instance.global_position = position
	instance.target_position = Target.global_position

func _ready() -> void:
	Timer.start()

func _on_Timer_timeout():
	if count > 0:
		instance_scene_on_spawn(EnemyMelee, Spawn.global_position)
		count -= 1
	else:
		Timer.stop()
