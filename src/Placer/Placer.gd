extends Node2D

onready var Container := $Container

var positions: Dictionary;
var current_position := 'f2';

func set_container_postion(_position: String) -> void:
	if (current_position == 'f1' and _position == 'f3') or (current_position == 'f3' and _position == 'f1'):
		print('cannot replace')
	else	:
		Container.global_position = positions[_position]
		current_position = _position

func _ready() -> void:
	positions = {
		'f1': $PositionA.global_position,
		'f2': $PositionB.global_position,
		'f3': $PositionC.global_position
	}
	set_container_postion(current_position)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("f1"):
		set_container_postion('f1')
	elif Input.is_action_just_pressed("f2"):
		set_container_postion('f2')
	elif Input.is_action_just_pressed("f3"):
		set_container_postion('f3')
