extends Enemy

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

onready var attack_timer := $AttackTimer
onready var navigation_agent = $NavigationAgent2D
onready var path_timer = $PathTimer

var is_attacking := false
var velocity = Vector2.ZERO
var is_started_path = false

func update_path_finding() -> void:
	navigation_agent.set_target_location(MainInstances.Player.global_position)

func _ready() -> void:
	path_timer.connect('timeout', self, 'update_path_finding')

func attack(mode: bool) -> void:
	is_attacking = mode
	attack_timer.start() if mode else attack_timer.stop()

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		if not is_attacking and is_started_path:
			attack(true)
		return

	if is_attacking and is_started_path:
		attack(false)

	var direction = global_position.direction_to(navigation_agent.get_next_location())
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 4.0
	velocity += steering
	navigation_agent.set_velocity(velocity)
	velocity = move_and_slide(velocity)
	is_started_path = true

func _on_Timer_timeout() -> void:
	print('bumsss')
	PlayerStats.take_damage(damage, attack_type)
