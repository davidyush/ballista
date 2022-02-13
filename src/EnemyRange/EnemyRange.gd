extends KinematicBody2D

export (int) var speed = 10

var Bullet := preload("res://src/EnemyRange/EnemyBullet.tscn")

var target_position := Vector2.ZERO
var initial_position := Vector2.ZERO
var switch_direction := 1
var is_dead := false

func _process(delta: float) -> void:
	position = position.move_toward(
		target_position if switch_direction == 1 else initial_position,
		delta * 50
	)

func _on_Timer_timeout() -> void:
	#need player position here
	print("fire_bullet")
