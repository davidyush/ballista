extends KinematicBody2D

var target_position := Vector2.ZERO

func _process(delta: float) -> void:
	position = position.move_toward(target_position, delta * 10)
