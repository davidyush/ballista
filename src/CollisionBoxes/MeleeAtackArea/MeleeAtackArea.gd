extends Area2D

func _on_MeleeAtackArea_body_entered(body: KinematicBody2D) -> void:
	body.is_attacking = true

func _on_MeleeAtackArea_body_exited(body: KinematicBody2D) -> void:
	body.is_attacking = false
