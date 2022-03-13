extends Control

func _ready() -> void:
	$LabelStrikes.text = "Strikes: " + str(GlobalStatistics.strikes)
	$LabelHits.text = "Hits: " + str(GlobalStatistics.hits)


func _on_Button_pressed() -> void:
	get_tree().change_scene("res://src/Levels/Forest/Level_Forest_00.tscn")
