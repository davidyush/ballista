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


#armor types: "nope", "light", "medium", "heavy"
#attack_types: "nope", "common", "magic"
func calc_damage(damage: float, armor: float, attack_type: String, armor_type: String) -> float:
	return damage


func get_parent_by_name(current_node: Node, name: String) -> Node:
	var current_parent = current_node.get_parent()
	while current_parent != null:
		if current_parent.name.begins_with(name):
			return current_parent
		else:
			current_parent = current_parent.get_parent()
	return null
