@tool
class_name Pacman
extends GridBasedEntity

func _init() -> void:
	Globals.pacman = self

func _ready() -> void:
	super()
	Globals.player_ready.emit()

func get_current_tile() -> Vector2i:
	return movement_component.current_tile
