extends Node

var strikes := 0
var hits := 0
var time := 0.0

func increment_strikes() -> void:
	strikes += 1
	
func increment_hits() -> void:
	hits += 1

func set_time(value: float) -> void:
	time += value
