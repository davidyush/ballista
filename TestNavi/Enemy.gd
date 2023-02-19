extends KinematicBody2D

export var path_to_player = NodePath()

onready var _agent = $NavigationAgent2D
onready var _player = get_node(path_to_player)
onready var _timer = $Timer

var _velocity = Vector2.ZERO

func _ready() -> void:
	_update_path_finding()
	_timer.connect('timeout', self, '_update_path_finding')
	
func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		return
	var direction = global_position.direction_to(_agent.get_next_location())
	var desired_velocity = direction * 50.0
	var steering = (desired_velocity - _velocity) * delta * 4.0
	_velocity += steering
	_agent.set_velocity(_velocity)
	_velocity = move_and_slide(_velocity)

func _update_path_finding() -> void:
	_agent.set_target_location(_player.global_position)
