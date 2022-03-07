extends Enemy

onready var timer := $Timer

export (PackedScene) var Bullet
export (float) var bullet_speed := 50.0

var MainInstances = ResourceLoader.MainInstances

func _on_Timer_timeout() -> void:
	var bullet = Utils.instance_scene_on_main(Bullet, global_position)
	var velocity = (MainInstances.Player.global_position - global_position).normalized() * bullet_speed
	bullet.rotation = get_angle_to(MainInstances.Player.global_position)
	bullet.velocity = velocity
