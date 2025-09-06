class_name Ghost
extends GridBasedEntity

enum GhostNames {BLINKY, PINKY, INKY, CLYDE}

@export_category("Settings")
@export var ghost_name: GhostNames

func _ready() -> void:
	super()
	Globals.ghosts[ghost_name] = self
