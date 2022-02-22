extends KinematicBody2D

export (float) var speed := 50.0
export (float) var damage := 0.0
export (float) var health := 1.0
export (float) var armor := 0.0
export (String, "nope", "light", "medium", "heavy") var armor_type = "nope"
export (String, "nope", "common", "magic") var atack_type = "common"
export (float)var stun_time := 0.5
export (float) var fear_time := 0.5

var is_dead := false

func _on_Hurtbox_hit(damage: float, attack_type: String):
	print('enemy got damage ', damage, attack_type)
	is_dead = true
	queue_free()
