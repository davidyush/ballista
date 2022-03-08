extends Resource
class_name PlayerStatsClass

#armor info shoud be here
var max_health := 100
var health := max_health setget set_health

signal player_died

func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	if health == 0:
		emit_signal("player_died")

func take_damage(damage: float, attack_type: String) -> void:
	print('Player got damage ', damage, attack_type)
