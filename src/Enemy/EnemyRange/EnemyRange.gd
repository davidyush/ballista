extends "res://src/Enemy/Enemy.gd"

onready var timer := $Timer

var EnemyBullet = preload("res://src/Enemy/EnemyRange/EnemyBullet.tscn")

var MainInstances = ResourceLoader.MainInstances

func _on_Timer_timeout() -> void:
	var bullet = Utils.instance_scene_on_main(EnemyBullet, global_position)
	var velocity = (MainInstances.Player.global_position - global_position).normalized() * 50
	bullet.velocity = velocity
