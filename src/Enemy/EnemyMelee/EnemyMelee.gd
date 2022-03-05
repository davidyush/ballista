extends Enemy

var PlayerStats = ResourceLoader.PlayerStats

onready var timer := $Timer

var is_attacking := false

func _physics_process(delta: float) -> void:
	if is_attacking and timer.is_stopped():
		timer.start()
	elif not is_attacking and not timer.is_stopped():
		timer.stop()
	
func _on_Timer_timeout() -> void:
	print('meele attacks by ', damage)
	PlayerStats.health -= damage
