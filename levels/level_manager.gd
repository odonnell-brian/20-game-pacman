extends Node2D

func _ready() -> void:
	Globals.level_loaded.emit()
