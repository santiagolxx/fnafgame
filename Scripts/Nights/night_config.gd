# res://Scripts/Nights/night_config.gd
extends Resource
class_name NightConfig

@export_range(0, 20) var red_level: int = 0
@export_range(0, 20) var green_level: int = 0
@export var duration_seconds: int = 90
