extends Node2D

const Bullet := preload("res://src/Player/Bullet.tscn")

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

onready var Kata := $Kata
onready var Muzzle := $Kata/Muzzle

var time_start := 0.0
var time_passed := 0.0
var is_changing_rotation = true

func start_bullet() -> void:
	time_start = OS.get_ticks_msec();
	is_changing_rotation = false

func release_bullet() -> void:
	time_passed = (OS.get_ticks_msec() - time_start) / 1000.0;
	is_changing_rotation = true

func _on_died_Player() -> void:
	print('player is dead')

func _ready() -> void:
	MainInstances.Player = self
	PlayerStats.connect("player_deid", self, "_on_died_Player")

func _physics_process(delta: float) -> void:
	if is_changing_rotation:
		var _rotation := get_local_mouse_position().angle()
		Kata.rotation_degrees = int(rad2deg(_rotation))
	if Input.is_action_just_pressed("click"):
		start_bullet()

func _exit_tree() -> void:
	MainInstances.Player = null

func _on_Hurtbox_hit(damage: float) -> void:
	print('Player got damage ', damage)

func _on_VectorCreator_vector_created(vector: Vector2):
	var instance = Utils.create_instance(Bullet, Muzzle.global_position)
	release_bullet()
	instance.life_time = time_passed
	instance.velocity = vector
	get_tree().current_scene.add_child(instance)
