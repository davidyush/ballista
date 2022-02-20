extends Area2D

var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	position += velocity * delta


func _on_EnemyBullet_body_entered(body: KinematicBody2D):
	queue_free()
