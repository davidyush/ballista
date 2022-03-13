extends Area2D

onready var line := $Line2D
onready var ballista_line := $BallistaLine

signal vector_created(vector, distance)

var MainInstances = ResourceLoader.MainInstances

export var maximum_length := 200

var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO
var vector := Vector2.ZERO
var distance := 0.0

func _ready() -> void:
	connect("input_event", self, "_on_input_event")

func _physics_process(delta: float) -> void:
	if position_end != Vector2.ZERO:
		line.points = [position_start - global_position, position_end - global_position]
		distance = position_end.distance_to(position_start)
		line.default_color = Color.orange
		ballista_line.points = [
			position_start - global_position,
			ResourceLoader.MainInstances.Player.global_position - global_position
		]
		ballista_line.default_color = Color.aqua
	
func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	update()

func _input(event) -> void:
	if not touch_down:
		return   

	if event.is_action_released("ui_touch"):
		touch_down = false
		emit_signal("vector_created", vector, distance)
		ballista_line.points = []
		line.points = []
		_reset()

	if event is InputEventMouseMotion:
		position_end = event.position
		vector = -(ResourceLoader.MainInstances.Player.global_position - position_start).clamped(maximum_length)
		update()

func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position


