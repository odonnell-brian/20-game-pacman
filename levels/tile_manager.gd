class_name TileManager
extends Node2D

const TILE_SIZE := Vector2i(8, 8)
const TOP_LEFT_GLOBAL_POSITION := Vector2(208, 36)
const WALL_CUSTOM_DATA_KEY: String = "wall"

@export_category("Settings")
@export var maze_layer: TileMapLayer
@export var path_layer: TileMapLayer

# Static so that it can be used in the editor
static func get_tile_center_point(tile_coords: Vector2i) -> Vector2:
	var global_x: float = tile_coords.x * TILE_SIZE.x + (TILE_SIZE.x / 2.0) + TOP_LEFT_GLOBAL_POSITION.x
	var global_y: float = tile_coords.y * TILE_SIZE.y + (TILE_SIZE.y / 2.0)  + TOP_LEFT_GLOBAL_POSITION.y
	return Vector2(global_x, global_y)

func _init() -> void:
	Globals.tile_manager = self

func is_tile_movable(tile_coords: Vector2i) -> bool:
	var cell_data: TileData = maze_layer.get_cell_tile_data(tile_coords)

	if cell_data:
		return not cell_data.get_custom_data(WALL_CUSTOM_DATA_KEY)

	return true
