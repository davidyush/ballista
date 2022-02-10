extends Node2D

var EnemyRange := preload("res://src/EnemyRange/EnemyRange.tscn")

onready var SpawnLeft := $SpawnLeft
onready var SpawnRight := $SpawnRight
onready var Timer := $Timer

# need to get the number from global state of the game
var count := 1
var _gap := Vector2(20, 0)

func instance_scene_on_spawn(scene: PackedScene, position: Vector2, target: Vector2) -> void:
	var main := get_tree().current_scene
	var instance := scene.instance()
	main.add_child(instance)
	instance.global_position = position
	instance.initial_position = position
	instance.target_position = target

func _ready():
	Timer.start()

func get_random() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(0, 1)

func get_positions() -> Dictionary:
	if get_random() == 1:
		return {
			"init": SpawnLeft.global_position + _gap,
			"target": SpawnRight.global_position - _gap
		}
	return {
		"target": SpawnLeft.global_position + _gap,
		"init": SpawnRight.global_position - _gap
	}

func _on_Timer_timeout() -> void:
	if count > 0:
		var positions = get_positions()
		instance_scene_on_spawn(EnemyRange, positions.init, positions.target)
		count -= 1
	else:
		Timer.stop()


func _on_SpawnRight_body_entered(body: KinematicBody2D) -> void:
	body.switch_direction *= -1

func _on_SpawnLeft_body_entered(body: KinematicBody2D) -> void:
	body.switch_direction *= -1
