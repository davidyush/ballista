extends Node2D

onready var road := $Road
onready var player := $Road/Player
onready var line := $Line2D 

var current_path = null
var i = 1

func _ready() -> void:
	player.connect('finished_path', self, 'clear_line')
	player.connect('end_step', self, 'clear_step_line')

func _input(event):
	if event.is_action_pressed("mouse_left") and current_path == null:
		var target_cell = (event.position / road.cell_size).floor() * road.cell_size
		var path_points = road.get_astar_path_avoiding_obstacles(player.global_position, target_cell)
		current_path = path_points
		player.set_path(path_points)
		line.position = road.cell_size/2 # Use offset to move line to center of tiles
		line.points = path_points

func clear_line() -> void:
	line.points = []
	i = 1
	current_path = null

func clear_step_line() -> void:
	line.points = current_path.slice(i, current_path.size())
	i += 1
