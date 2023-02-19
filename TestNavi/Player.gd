extends KinematicBody2D

var speed = 100
var friction = 0.18
var _velocity := Vector2.ZERO

onready var obstacle = $'../Navigation2D/NavigationPolygonInstance4'

func _physics_process(delta: float) -> void:
	var direction = Vector2(
		Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left'),
		Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	)

	if direction.length() > 1.0:
		direction = direction.normalized()
	var target_velocity = direction * speed
	_velocity += (target_velocity - _velocity) * friction
	_velocity = move_and_slide(_velocity)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('click'):
		obstacle.queue_free()
