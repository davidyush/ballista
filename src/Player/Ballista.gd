extends Node2D

const Bullet := preload("res://src/Player/Bullet.tscn")

onready var Kata := $Kata
onready var Muzzle := $Kata/Muzzle

var time_start := 0

func start_bullet() -> void:
	time_start = OS.get_ticks_msec();
	
func release_bullet() -> float:
	var time_passed := (OS.get_ticks_msec() - time_start) / 1000.0;
	time_start = 0
	return time_passed

func instance_scene_on_main(scene: PackedScene, position: Vector2, rotation: float, life_time: float) -> void:
	var main := get_tree().current_scene
	var instance := scene.instance()
	instance.global_position = position
	instance.rotation = rotation
	instance.life_time = life_time
	instance.velocity = Vector2.RIGHT.rotated(rotation) * 300 * life_time * 2
	main.add_child(instance)

func _process(delta: float) -> void:
	var _rotation := get_local_mouse_position().angle()
	Kata.rotation_degrees = int(rad2deg(_rotation))
	if Input.is_action_just_pressed("click"):
		start_bullet()
	if Input.is_action_just_released("click"):
		var time_passed := release_bullet();
		instance_scene_on_main(Bullet, Muzzle.global_position, _rotation, time_passed)
