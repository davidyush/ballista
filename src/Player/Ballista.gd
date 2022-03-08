extends Node2D

const BulletPlayer := preload("res://src/Bullets/BulletPlayer/BulletPlayer.tscn")

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

onready var Kata := $Kata
onready var Muzzle := $Kata/Muzzle

var is_changing_rotation = true

func start_bullet() -> void:
	is_changing_rotation = false

func release_bullet() -> void:
	is_changing_rotation = true

func _on_died_Player() -> void:
	print('player is dead')
	queue_free()

func _ready() -> void:
	MainInstances.Player = self
	PlayerStats.connect("player_died", self, "_on_died_Player")

func _physics_process(_delta: float) -> void:
	if is_changing_rotation:
		var _rotation := get_local_mouse_position().angle()
		Kata.rotation_degrees = int(rad2deg(_rotation))
	if Input.is_action_just_pressed("click"):
		start_bullet()

func _exit_tree() -> void:
	MainInstances.Player = null

func _on_Hurtbox_hit(damage: float, attack_type: String) -> void:
	PlayerStats.take_damage(damage, attack_type)

func _on_VectorCreator_vector_created(vector: Vector2, speed: float) -> void:
	var instance = Utils.create_instance(BulletPlayer, Muzzle.global_position)
	release_bullet()
	instance.life_time =  speed * sin(PI/4.0) / 100
	instance.velocity = vector.normalized() * speed
	instance.rotation = Kata.rotation
	get_tree().current_scene.add_child(instance)
