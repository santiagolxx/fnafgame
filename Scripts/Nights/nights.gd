extends Node2D

var nights: Array[NightConfig] = []  # Array tipado para las configuraciones
var current_index: int = -1
var night_timer: Timer
var night_duration: float = 0.0

@onready var ai_manager = $CharacterAI  # Referencia al nodo AI
func _ready():
	_load_night_configs()
	start_next_night()
	$AmbientAudioPlayers/ambientStreamPlayer.play()
	$AmbientAudioPlayers/musicStreamPlayer.play()

func _load_night_configs():
	var dir = DirAccess.open("res://Config/Nights/")
	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			if dir.current_is_dir():
				file = dir.get_next()
				continue
			if file.ends_with(".tres"):
				nights.append(load("res://Config/Nights/" + file))
			file = dir.get_next()
		dir.list_dir_end()


func start_next_night():
	current_index += 1
	if current_index >= nights.size():
		print("¡Todas las noches completadas!")
		return

	var config = nights[current_index]
	night_duration = config.duration_seconds

	ai_manager.set_ai_levels(config.red_level, config.green_level)
	_setup_night_timer()

func _setup_night_timer():
	if night_timer:
		night_timer.queue_free()
	
	# Crear nuevo timer
	night_timer = Timer.new()
	night_timer.wait_time = night_duration
	night_timer.one_shot = true
	night_timer.timeout.connect(_on_night_completed)
	add_child(night_timer)
	night_timer.start()

func _on_night_completed():
	print("¡Noche ", current_index + 1, " completada!")
	# Aquí podrías mostrar una pantalla de "6 AM" o similar
	call_deferred("start_next_night")

func get_current_night() -> int:
	return current_index + 1

func get_night_time() -> float:
	if night_timer:
		return night_duration - night_timer.time_left
	return 0.0

func get_night_progress() -> float:
	if night_timer and night_duration > 0:
		return (night_duration - night_timer.time_left) / night_duration
	return 0.0
