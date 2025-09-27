extends Control

# Escena a cargar después del fade
const MENU_SCENE_PATH := "res://Scenes/Menu/menu.tscn"

# Nodos
@onready var animation_player: AnimationPlayer = $animation
@onready var timer: Timer = $Timer

func _ready() -> void:
	# Conectar señal con Callable
	animation_player.animation_finished.connect(Callable(self, "_on_animation_finished"))

# Método llamado por el Timer
func _on_timer_timeout() -> void:
	# Inicia la animación de fade
	animation_player.play("Fade out")

# Método llamado cuando la animación termina
func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade out":
		# Cambia de escena después de la animación
		get_tree().change_scene_to_file(MENU_SCENE_PATH)
