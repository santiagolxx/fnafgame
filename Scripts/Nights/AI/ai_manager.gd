# res://Scripts/Nights/ai_manager.gd
extends Node

func set_ai_levels(red: int, green: int) -> void:
	$Red.ai_level = red
	$Green.ai_level = green
