extends Node2D

const BulletPlayer := preload("res://src/Bullets/BulletPlayer/BulletPlayer.tscn")

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

onready var BallistaBody := $BallistaBody
onready var Muzzle := $BallistaBody/Muzzle

var is_changing_rotation = true

func start_bullet() -> void:
	is_changing_rotation = false

func release_bullet() -> void:
	is_changing_rotation = true

func _on_died_Player() -> void:
	print('player is dead')
	GlobalStatistics.is_player_died = true
	get_tree().change_scene("res://src/Menus/EndScreen.tscn")
	queue_free()

func _ready() -> void:
	MainInstances.Player = self
	PlayerStats.connect("player_died", self, "_on_died_Player")

func _physics_process(_delta: float) -> void:
	if is_changing_rotation:
		var _rotation := get_local_mouse_position().angle()
		BallistaBody.rotation_degrees = int(rad2deg(_rotation))
	if Input.is_action_just_pressed("click"):
		start_bullet()

func _exit_tree() -> void:
	MainInstances.Player = null

func _on_Hurtbox_hit(damage: float, attack_type: String) -> void:
	PlayerStats.take_damage(damage, attack_type)

func _on_LineCreator_line_created(vector: Vector2, speed: float) -> void:
	var instance = Utils.create_instance(BulletPlayer, Muzzle.global_position)
	release_bullet()
	instance.life_time = speed * 0.006
	instance.velocity = vector.normalized() * speed * 1.4045
	print('life_time ', instance.life_time)
	print('speed (distance) ', speed)
	print('vector ', vector)
	instance.rotation = BallistaBody.rotation
	get_tree().current_scene.add_child(instance)
	GlobalStatistics.increment_strikes()
