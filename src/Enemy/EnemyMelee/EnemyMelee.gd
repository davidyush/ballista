extends Enemy

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

onready var attack_timer := $AttackTimer
onready var navigation_agent = $NavigationAgent2D
onready var path_timer = $PathTimer

var is_attacking := false
var velocity = Vector2.ZERO

func update_path_finding() -> void:
	navigation_agent.set_target_location(MainInstances.Player.global_position)

func _ready() -> void:
	path_timer.connect('timeout', self, 'update_path_finding')

func start_attacking() -> void:
	if is_attacking and attack_timer.is_stopped():
		attack_timer.start()
	elif not is_attacking and not attack_timer.is_stopped():
		attack_timer.stop()

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		start_attacking()

	var direction = global_position.direction_to(navigation_agent.get_next_location())
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 4.0
	velocity += steering
	navigation_agent.set_velocity(velocity)
	velocity = move_and_slide(velocity)
	
	
func _on_Timer_timeout() -> void:
	PlayerStats.take_damage(damage, attack_type)
