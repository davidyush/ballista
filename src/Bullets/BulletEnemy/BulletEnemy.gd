extends "res://src/Bullets/Bullet.gd"

func _on_BulletEnemy_body_entered(body):
	queue_free()
