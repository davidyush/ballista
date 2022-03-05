extends Enemy

onready var timer := $Timer

export (PackedScene) var Bullet

var MainInstances = ResourceLoader.MainInstances

func _on_Timer_timeout() -> void:
	var bullet = Utils.instance_scene_on_main(Bullet, global_position)
	var velocity = (MainInstances.Player.global_position - global_position).normalized() * 50
	bullet.velocity = velocity
