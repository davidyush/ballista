extends Bullet

func _on_BulletEnemy_body_entered(body: KinematicBody2D) -> void:
	queue_free()
