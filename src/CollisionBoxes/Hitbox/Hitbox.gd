extends Area2D

export (float) var damage = 1.0
export (String, "nope", "common", "magic") var atack_type = "common"

func _on_Hitbox_area_entered(hurtbox: Area2D) -> void:
	print(hurtbox.name)
	hurtbox.emit_signal("hit", damage, atack_type)
