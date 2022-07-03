extends Control

onready var LabelTimer := $LabelTimer
onready var LevelTimer := $LevelTimer
onready var LabelEnemies := $LabelEnemies

var time_passed = 0.0

func _physics_process(delta: float) -> void:
	LabelTimer.text = "%.2f" % (time_passed + (1 - LevelTimer.time_left))

func _on_LevelTimer_timeout() -> void:
	time_passed += 1

func set_label_enemies(killed: int, count: int) -> void:
	LabelEnemies.text = str(killed) + '/' + str(count)

func _exit_tree() -> void:
	GlobalStatistics.set_time(float(LabelTimer.text))
