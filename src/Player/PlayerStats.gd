extends Resource
class_name PlayerStatsClass

#armor info shoud be here
var max_health := 100
var health := max_health setget set_health
var armor := 1.0
var armor_coefficient := 1.0
var armor_type := 'none'

signal player_died

func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	if health == 0:
		emit_signal("player_died")

func take_damage(damage: float, attack_type: String) -> void:
	var final_damage = Utils.calc_damage(damage, armor, armor_coefficient, attack_type, armor_type)
	health -= final_damage
	print('Player got damage ', final_damage)
