extends "res://src/Enemy/Enemy.gd"

onready var timer := $Timer

var BulletEnemy = preload("res://src/Bullets/BulletEnemy/BulletEnemy.tscn")

var MainInstances = ResourceLoader.MainInstances

func _on_Timer_timeout() -> void:
	var bullet = Utils.instance_scene_on_main(BulletEnemy, global_position)
	var velocity = (MainInstances.Player.global_position - global_position).normalized() * 50
	bullet.velocity = velocity
