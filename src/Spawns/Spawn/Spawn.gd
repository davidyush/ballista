extends Node2D

onready var path_follow := $Path2D/PathFollow2D

export (Array, PackedScene) var enemies
export (bool) var is_looped := false
export (float) var delay := 0.0 

var enemies_count := 0
var current_index := 0
var current_speed := 0
var current_instance :KinematicBody2D = null

func _ready() -> void:
	enemies_count = enemies.size()
	path_follow.loop = is_looped
	set_enemy(current_index)

func _physics_process(delta: float) -> void:
	path_follow.offset += current_speed * delta

func set_enemy(index: int) -> void:
	current_instance = enemies[index].instance()
	yield(get_tree().create_timer(delay), "timeout")
	current_speed = current_instance.speed
	path_follow.add_child(current_instance)

func set_next() -> void:
	if current_instance != null and current_instance.is_dead:
		path_follow.offset = 0
		current_speed = 0.0
		if current_index + 1 != enemies_count:
			current_index += 1
			set_enemy(current_index)
		else:
			var level = Utils.get_parent_by_name(self, 'Level')
			level.is_level_completed()
			queue_free()
