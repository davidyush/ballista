extends KinematicBody2D

export (float) var speed = 50.0
export (float) var damage = 0.0
export (float) var health = 1.0
export (float) var armor = 0.0
var is_dead := false

#TODO: type of armor (by Resource probably)

func _on_Hurtbox_hit(damage):
	print('enemy has been damaged')
	is_dead = true
	queue_free()

