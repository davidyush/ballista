extends "res://src/Bullets/Bullet.gd"

onready var hitbox := $Hitbox
onready var timer := $Timer

var life_time := 0.0

func _ready():
	hitbox.monitoring = false
	print(float(life_time))
	timer.wait_time = max(life_time, 0.1)
	timer.start()

func _on_Timer_timeout():
	hitbox.monitoring = true
	velocity = Vector2.ZERO
	yield(get_tree().create_timer(0.04), "timeout")
	queue_free()
