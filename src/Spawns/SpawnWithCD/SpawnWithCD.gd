extends Node2D

export var cool_dawn := 0.5
export var limit := 5
export var EnemyScene: PackedScene = null

onready var Timer := $Timer
onready var Path := $Path2D

var current_speed := 0
var ordinary := false
var current_iteration := 0
var count := 0

func check_emptiness() -> void:
	count += 1
	if count == limit:
		queue_free()

func _ready() -> void:
	Timer.wait_time = cool_dawn
	Timer.start()
	current_speed = EnemyScene.instance().speed


func _physics_process(delta: float) -> void:
	for pathFollow in Path.get_children():
		pathFollow.offset += current_speed * delta


func _on_Timer_timeout() -> void:
	if current_iteration < limit:
		var pathFollow = PathFollow2D.new()
		pathFollow.add_child(EnemyScene.instance())
		pathFollow.loop = false
		pathFollow.rotate = false
		Path.add_child(pathFollow)
		current_iteration += 1
	else:
		Timer.stop()
