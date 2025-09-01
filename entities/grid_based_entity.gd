@tool
class_name GridBasedEntity
extends Node2D

@export_category("Settings")
@export var starting_tile: Vector2i
@export var update_position_in_editor: bool

@export_category("Optional Dependencies")
@export var movement_component: MovementComponent

func _ready() -> void:
	if movement_component:
		movement_component.current_tile = starting_tile

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() and update_position_in_editor:
		global_position = TileManager.get_tile_center_point(starting_tile)
