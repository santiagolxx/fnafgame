extends Node2D

@export var nights: Array[Resource]  # Tus .tres
var current_index: int = -1
var night_timer: Timer
var night_duration: float = 0.0

func _ready():
	start_next_night()
	set_process(true)

func start_next_night():
	current_index += 1
	if current_index >= nights.size():
		print("Todas las noches completadas")
		return

	var cfg = nights[current_index]
	night_duration = cfg.duration_seconds

	# Inicializar IA aquí, si quieres
	# $AIManager.set_ai_levels(cfg.red_level, cfg.green_level)
	print(cfg.red_level)

	# Crear timer
	if night_timer:
		night_timer.queue_free()
	night_timer = Timer.new()
	night_timer.wait_time = night_duration
	night_timer.one_shot = true
	add_child(night_timer)
	night_timer.start()
func get_current_night() -> int:
	return current_index + 1

func get_night_time() -> float:
	if night_timer:
		return night_duration - night_timer.time_left
	return 0.0
