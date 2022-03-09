extends Control

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_cancel'):
		get_tree().paused = true
		visible = true

func _on_Button_pressed() -> void:
	get_tree().paused = false
	visible = false
