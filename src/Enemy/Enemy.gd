extends KinematicBody2D
class_name Enemy

export (float) var speed := 50.0
export (float) var damage := 1.0
export (float) var health := 1.0
export (float) var armor := 0.0
export (String, "nope", "light", "medium", "heavy") var armor_type = "nope"
export (String, "nope", "common", "magic") var atack_type = "common"
export (float)var stun_time := 0.5
export (float) var fear_time := 0.5

var is_dead := false

func _on_Hurtbox_hit(_damage: float, _attack_type: String) -> void:
	print('enemy got damage ', _damage, _attack_type)
	var final_damage = Utils.calc_damage(_damage, armor, _attack_type, armor_type)
	health -= final_damage
	if health <= 0.0:
		is_dead = true
		var spawn = Utils.get_parent_by_name(self, 'Spawn')
		spawn.set_next()
		queue_free()
