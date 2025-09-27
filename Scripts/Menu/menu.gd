extends Node2D

# Nodos
@onready var menuStatic = $menuStatic
@onready var menuThemePlayer = $menuThemePlayer
@onready var AnimatronicSprite = $menuAnimatronic
@onready var newGameSelect = $CanvasLayer2/menuNewGameSelect
@onready var continueSelect = $CanvasLayer2/menuContinueSelect

func _ready() -> void:
	menuStatic.play()
	menuThemePlayer.play()

# Animación del animatrónico
func _on_animatronic_timer_timeout() -> void:
	AnimatronicSprite.play("default")

# Hover sobre los labels
func _on_menu_new_game_mouse_entered() -> void:
	newGameSelect.show()

func _on_menu_new_game_mouse_exited() -> void:
	newGameSelect.hide()

func _on_menu_continue_mouse_entered() -> void:
	continueSelect.show()

func _on_menu_continue_mouse_exited() -> void:
	continueSelect.hide()

# Click en New Game → directamente Nights.tscn
func _on_menu_new_game_clicked() -> void:
	var nights_scene = preload("res://Scenes/Nights/Nights.tscn").instantiate()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(nights_scene)

# Click en Continue → también directamente Nights.tscn
func _on_menu_continue_clicked() -> void:
	var nights_scene = preload("res://Scenes/Nights/Nights.tscn").instantiate()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(nights_scene)
