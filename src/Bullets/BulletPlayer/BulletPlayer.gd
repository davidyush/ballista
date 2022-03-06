extends Bullet

onready var hitbox := $Hitbox
onready var timer := $Timer

var life_time := 0.0
var flight_time := 0.0
var H_max := 0.00000000001
var H_current := 0.00000000001
var current_time := 0.00000000001


func _ready() -> void:
	hitbox.monitoring = false
	timer.wait_time = max(life_time, 0.1)
	flight_time = velocity.length() * sin(PI/4.0) / 9.8
	print ('flight_time ', flight_time)
	H_max = 0.00000000001 +  (velocity.length() * velocity.length() * sin(PI/4.0) * sin(PI/4.0) )/(2 * 9.8) 
	print ('H_max ', H_max )
	timer.start()
#ss
func _physics_process(delta: float) -> void:
	._physics_process(delta)
	H_current = 0.00000000001 + velocity.length() * sin(PI/4.0) * current_time - ( 9.8 * current_time * current_time) / 2.0
	current_time += delta
	#print ('current_time ' , current_time )
	print ('H_current' , H_current )
	scale.x= H_current/H_max
	


func _on_Timer_timeout() -> void:
	hitbox.monitoring = true
	velocity = Vector2.ZERO
	yield(get_tree().create_timer(0.04), "timeout")
	queue_free()
