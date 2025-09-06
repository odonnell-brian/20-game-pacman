@tool
class_name ShowPositionInEditorComponent
extends Node2D

@export_category("Settings")
@export var node_to_change: Node2D = self
@export var position_to_show: Vector2i
@export var update_parent_starting_tile: bool = false
@export var disable: bool = false
@export var snap_to_nearest_tile: bool = false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() and not disable:
		node_to_change.global_position = TileManager.get_tile_center_point(position_to_show)

		if update_parent_starting_tile and node_to_change is GridBasedEntity:
			(node_to_change as GridBasedEntity).starting_tile = position_to_show
