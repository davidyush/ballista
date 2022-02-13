extends KinematicBody2D

export (int) var speed = 10

var target_position := Vector2.ZERO
var is_dead := false

func _process(delta: float) -> void:
	position = position.move_toward(target_position, delta * 10)
