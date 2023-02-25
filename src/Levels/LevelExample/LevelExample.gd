extends Node2D

onready var _spawns = $Spawns
onready var _level_ui = $LevelUI

const MARGIN_CONNECTION = 10

func _ready() -> void:
	Navigation2DServer.map_set_edge_connection_margin(
		get_world_2d().get_navigation_map(), MARGIN_CONNECTION
	)
	_level_ui.set_label_enemies(0, get_enemies_amount())
	

func get_enemies_amount() -> int:
	var amount = 0
	for spawn in _spawns.get_children():
		amount += spawn.amount
	return amount
