extends Node2D

const Bullet := preload("res://src/Player/Bullet.tscn")

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

onready var Kata := $Kata
onready var Muzzle := $Kata/Muzzle

var time_start := 0
var time_passed := 0

func start_bullet() -> void:
	time_start = OS.get_ticks_msec();
	
func release_bullet() -> float:
	var time_passed := (OS.get_ticks_msec() - time_start) / 1000.0;
	time_start = 0
	return time_passed

func instance_scene_on_main(scene: PackedScene, position: Vector2, rotation: float, life_time: float) -> void:
	var main := get_tree().current_scene
	var instance := scene.instance()
	instance.global_position = position
	instance.rotation = rotation
	instance.life_time = life_time
	instance.velocity = Vector2.RIGHT.rotated(rotation) * 300 * life_time * 2
	main.add_child(instance)

func _on_died_Player() -> void:
	print('player is dead')

func _ready() -> void:
	MainInstances.Player = self
	PlayerStats.connect("player_deid", self, "_on_died_Player")

func _physics_process(delta: float) -> void:
	var _rotation := get_local_mouse_position().angle()
	Kata.rotation_degrees = int(rad2deg(_rotation))
	if Input.is_action_just_pressed("click"):
		start_bullet()
	if Input.is_action_just_released("click"):
		time_passed = release_bullet();
#		instance_scene_on_main(Bullet, Muzzle.global_position, _rotation, time_passed)

func _exit_tree() -> void:
	MainInstances.Player = null

func _on_Hurtbox_hit(damage: float) -> void:
	print('Player got damage ', damage)

func _on_VectorCreator_vector_created(vector: Vector2):
	var instance = Utils.create_instance(Bullet, Muzzle.global_position)
	instance.life_time = 1.0
	instance.velocity = vector * 2
	get_tree().current_scene.add_child(instance)
