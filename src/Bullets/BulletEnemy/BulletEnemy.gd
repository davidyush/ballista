extends Bullet

func _on_BulletEnemy_body_entered(body) -> void:
	queue_free()
