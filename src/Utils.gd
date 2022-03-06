extends Node

func instance_scene_on_main(scene: PackedScene, position: Vector2) -> Node:
	var main := get_tree().current_scene
	var instance := scene.instance()
	main.add_child(instance)
	instance.global_position = position
	return instance

func create_instance(scene: PackedScene, position: Vector2) -> Node:
	var instance := scene.instance()
	instance.global_position = position
	return instance

func get_random(min_num: int, max_num: int) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(min_num, max_num)

func calc_damage(damage: float, armor: float, attack_type: String, armor_type: String) -> float:
		return damage
