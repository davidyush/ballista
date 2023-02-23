extends KinematicBody2D

export var path_to_player = NodePath()

onready var _player = get_node(path_to_player)
onready var _navigatiion_agent = $NavigationAgent2D
onready var _timer = $Timer

var velocity = Vector2.ZERO
var SPEED = 20

func _update_path_finding() -> void:
	_navigatiion_agent.set_target_location(_player.global_position)

func _ready() -> void:
	_timer.connect('timeout', self, '_update_path_finding')
	
func _physics_process(delta: float) -> void:
	if _navigatiion_agent.is_navigation_finished():
		return
		
	var direction = global_position.direction_to(_navigatiion_agent.get_next_location())
	var desired_velocity = direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 4.0
	velocity += steering
	_navigatiion_agent.set_velocity(velocity)
	velocity = move_and_slide(velocity)

	#var move_direction = position.direction_to(_navigatiion_agent.get_next_location())
	#velocity = move_direction * SPEED
	#_navigatiion_agent.set_velocity(velocity)
	#velocity = move_and_slide(velocity)
	
	
	
