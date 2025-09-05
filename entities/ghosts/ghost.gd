class_name Ghost
extends GridBasedEntity

enum GhostNames {BLINKY, PINKY, INKY, CLYDE}

@export_category("Settings")
@export var ghost_name: GhostNames

func _init() -> void:
	Globals.ghosts[ghost_name] = self
