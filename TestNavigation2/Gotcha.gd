extends Node2D

func _ready() -> void:
	Navigation2DServer.map_set_edge_connection_margin(get_world_2d().get_navigation_map(), 10)
