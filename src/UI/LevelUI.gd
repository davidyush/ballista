extends Control

onready var LabelTimer = $LabelTimer
onready var LevelTimer = $LevelTimer

var time_passed = 0.0

func _physics_process(delta: float) -> void:
	LabelTimer.text = "%.2f" % (time_passed + (1 - LevelTimer.time_left))

func _on_LevelTimer_timeout() -> void:
	time_passed += 1
