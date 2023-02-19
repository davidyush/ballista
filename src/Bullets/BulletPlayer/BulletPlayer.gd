extends Bullet

onready var hitbox := $Hitbox
onready var timer := $Timer

var life_time := 0.0
const scaler := 2


func _ready() -> void:
	life_time = max(life_time, 0.1)
	hitbox.monitoring = false
	timer.wait_time = life_time
	timer.start()

func _physics_process(delta: float) -> void:
	if life_time / 2 < timer.get_time_left():
		scale = Vector2(scale.x + delta * scaler, scale.y + delta * scaler)
	else:
		scale = Vector2(scale.x - delta * scaler, scale.y - delta * scaler)

func _on_Timer_timeout() -> void:
	hitbox.monitoring = true
	velocity = Vector2.ZERO
	yield(get_tree().create_timer(0.04), "timeout")
	queue_free()
