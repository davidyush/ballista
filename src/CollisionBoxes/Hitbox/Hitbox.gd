extends Area2D

export (float) var damage = 1.0

func _on_Hitbox_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("hit", damage)
