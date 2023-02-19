class_name AstarTileMap
extends TileMap

const DIRECTIONS := [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

var astar := AStar2D.new()
var obstacles := []
var units := []

func add_obstacle(obstacle: Object) -> void:
	obstacles.append(obstacle)
	if not obstacle.is_connected("tree_exiting", self, "remove_obstacle"):
		obstacle.connect("tree_exiting", self, "remove_obstacle", [obstacle])

func remove_obstacle(obstacle: Object) -> void:
	obstacles.erase(obstacle)

func _ready() -> void:
	update()


func update() -> void:
	create_pathfinding_points()
	var obstacleNodes = get_tree().get_nodes_in_group("Obstacles")
	for obstacleNode in obstacleNodes:
		add_obstacle(obstacleNode)


func get_point(point_position: Vector2) -> int:
	var a := int(point_position.x)
	var b := int(point_position.y)
	return (a + b) * (a + b + 1) / 2 + b


func get_used_cell_global_positions() -> Array:
	var cells = get_used_cells()
	var cell_positions := []
	for cell in cells:
		var cell_position := global_position + map_to_world(cell)
		cell_positions.append(cell_position)
	return cell_positions


func connect_cardinals(point_position) -> void:
	var center := get_point(point_position)
	for direction in DIRECTIONS:
		var cardinal_point := get_point(point_position + map_to_world(direction))
		if cardinal_point != center and astar.has_point(cardinal_point):
			astar.connect_points(center, cardinal_point, true)


func create_pathfinding_points() -> void:
	astar.clear()
	var used_cell_positions = get_used_cell_global_positions()
	for cell_position in used_cell_positions:
		astar.add_point(get_point(cell_position), cell_position)

	for cell_position in used_cell_positions:
		connect_cardinals(cell_position) 

func set_obstacles_points_disabled(value: bool) -> void:
	for obstacle in obstacles:
		astar.set_point_disabled(get_point(obstacle.global_position), value)


func position_has_unit(unit_position: Vector2, ignore_unit_position := null) -> bool:
	if unit_position == ignore_unit_position: return false
	for unit in units:
		if unit.global_position == unit_position: return true
	return false

func stop_path_at_unit(potential_path_points: Array) -> Array:
	for i in range(1, potential_path_points.size()):
		var point : Vector2 = potential_path_points[i]
		if position_has_unit(point):
			potential_path_points.resize(i)
			break
	return potential_path_points
	
func set_path_length(point_path: Array, max_distance: int) -> Array:
	if max_distance < 0: return point_path
	point_path.resize(min(point_path.size(), max_distance))
	return point_path

func get_astar_path_avoiding_obstacles(start_position: Vector2, end_position: Vector2, max_distance := -1) -> Array:
	set_obstacles_points_disabled(true)
	var potential_path_points := astar.get_point_path(get_point(start_position), get_point(end_position))
	set_obstacles_points_disabled(false)
	var astar_path := stop_path_at_unit(potential_path_points)
	return set_path_length(astar_path, max_distance)
