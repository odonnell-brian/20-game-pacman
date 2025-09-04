class_name TileManager
extends Node2D

const TILE_SIZE := Vector2i(8, 8)
const TOP_LEFT_GLOBAL_POSITION := Vector2(208, 36)
const WALL_CUSTOM_DATA_KEY: String = "wall"

const DIRECTION_TO_CELL_NEIGHBOR: Dictionary[Vector2i, TileSet.CellNeighbor] = {
	Vector2i.UP: TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE,
	Vector2i.LEFT: TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE,
	Vector2i.DOWN: TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE,
	Vector2i.RIGHT: TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE,
}

const CELL_NEIGHBOR_TO_DIRECTION: Dictionary[TileSet.CellNeighbor, Vector2i] = {
	TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE: Vector2i.UP,
	TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE: Vector2i.LEFT,
	TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE: Vector2i.DOWN,
	TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE: Vector2i.RIGHT,
}

@export_category("Settings")
@export var maze_layer: TileMapLayer
@export var custom_adjacencies: Dictionary[Vector2i, CustomAdjacency]

var a_star_grid: AStarGrid2D

# Static so that it can be used in the editor
static func get_tile_center_point(tile_coords: Vector2i) -> Vector2:
	var global_x: float = tile_coords.x * TILE_SIZE.x + (TILE_SIZE.x / 2.0) + TOP_LEFT_GLOBAL_POSITION.x
	var global_y: float = tile_coords.y * TILE_SIZE.y + (TILE_SIZE.y / 2.0)  + TOP_LEFT_GLOBAL_POSITION.y
	return Vector2(global_x, global_y)

func _init() -> void:
	Globals.tile_manager = self

func _ready() -> void:
	set_up_a_star()

func set_up_a_star() -> void:
	a_star_grid = AStarGrid2D.new()
	a_star_grid.cell_size = TILE_SIZE
	a_star_grid.region = maze_layer.get_used_rect()
	a_star_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	a_star_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER

	a_star_grid.update()

	for cell in maze_layer.get_used_cells():
		a_star_grid.set_point_solid(cell, !is_tile_movable(cell))

func get_movement_path(from: Vector2i, to: Vector2i) -> Array[Vector2i]:
	var full_path: Array[Vector2i] = a_star_grid.get_id_path(from , to, true)

	return full_path.slice(1) # The first node in the path is the current tile

func get_traversible_neighbors(coordinates: Vector2i) -> Array[Vector2i]:
	var neighbors: Array[Vector2i] = []

	for cell in get_prioritized_surrounding_cells(coordinates):
		if is_tile_movable(cell):
			neighbors.append(cell)

	return neighbors

func get_prioritized_surrounding_cells(coords: Vector2i) -> Array[Vector2i]:
	var cells: Array[Vector2i] = []

	cells.append(get_custom_neighbor_or_default(coords, TileSet.CELL_NEIGHBOR_TOP_SIDE))
	cells.append(get_custom_neighbor_or_default(coords, TileSet.CELL_NEIGHBOR_LEFT_SIDE))
	cells.append(get_custom_neighbor_or_default(coords, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
	cells.append(get_custom_neighbor_or_default(coords, TileSet.CELL_NEIGHBOR_RIGHT_SIDE))

	return cells

func get_neighbor_in_direction(coords: Vector2i, direction: Vector2i) -> Vector2i:
	if direction == Vector2i.ZERO:
		return coords

	return get_custom_neighbor_or_default(coords, DIRECTION_TO_CELL_NEIGHBOR.get(direction))

func get_custom_neighbor_or_default(coords: Vector2i, side: TileSet.CellNeighbor) -> Vector2i:
	var default_neighbor: Vector2i = maze_layer.get_neighbor_cell(coords, side)
	var custom_adjacency: CustomAdjacency = custom_adjacencies.get(coords)
	if custom_adjacency and custom_adjacency.side == side:
		return custom_adjacency.adjacent_coord

	return default_neighbor

func get_direction_to(from: Vector2i, to: Vector2i) -> Vector2i:
	var custom_adjacency: CustomAdjacency = custom_adjacencies.get(from)

	if custom_adjacency and custom_adjacency.adjacent_coord == to:
		return CELL_NEIGHBOR_TO_DIRECTION.get(custom_adjacency.side)

	return to - from

func is_tile_movable(tile_coords: Vector2i) -> bool:
	var cell_data: TileData = maze_layer.get_cell_tile_data(tile_coords)

	if cell_data:
		return not cell_data.get_custom_data(WALL_CUSTOM_DATA_KEY)

	return true
