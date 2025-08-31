@tool
class_name GridBasedEntity
extends Node2D

const TILE_SIZE := Vector2i(8, 8)
const TOP_LEFT_GLOBAL_POSITION := Vector2(208, 52)

@export var grid_position: Vector2i

func _process(_delta: float) -> void:
	var global_x: float = grid_position.x * TILE_SIZE.x + (TILE_SIZE.x / 2.0) + TOP_LEFT_GLOBAL_POSITION.x
	var global_y: float = grid_position.y * TILE_SIZE.y + (TILE_SIZE.y / 2.0)  + TOP_LEFT_GLOBAL_POSITION.y
	global_position = Vector2(global_x, global_y)
