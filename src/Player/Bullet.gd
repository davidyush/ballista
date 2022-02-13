extends Area2D

onready var hitbox := $Hitbox
onready var timer := $Timer

var velocity := Vector2.ZERO
var life_time := 0.0

func _ready():
	#hitbox.monitoring = false
	timer.wait_time = life_time - 0.2
	timer.start()

func _physics_process(delta):
	position += velocity * delta

func _on_Timer_timeout():
	#hitbox.monitoring = true
	velocity = Vector2.ZERO
