extends Resource
class_name PlayerStatsClass

var max_health := 10000
var health := max_health setget set_health

signal player_died

func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	if health == 0:
		emit_signal("player_died")
