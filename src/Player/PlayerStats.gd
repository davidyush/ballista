extends Resource
class_name PlayerStatsClass

#armor info shoud be here
var max_health := 10.0
var health := max_health
var armor := 0.1
var armor_coefficient := 1.0
var armor_type := 'none'

signal player_died

func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	if health == 0:
		emit_signal("player_died")

func take_damage(damage: float, attack_type: String) -> void:
	var final_damage = Utils.calc_damage(damage, armor, armor_coefficient, attack_type, armor_type)
	set_health(health - final_damage)
