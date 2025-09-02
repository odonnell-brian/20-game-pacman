class_name SimplePathfindingComponent
extends MovementDirectionComponent

@export_category("Dependencies")
@export var movement_component: MovementComponent

@export_category("Settings")
@export var scatter_target: Vector2i = Vector2i.ZERO

var prev_tile: Vector2i = Vector2i(-1, -1)
var path: Array[Vector2i]

func _ready() -> void:
	Globals.level_loaded.connect(on_level_loaded)
	movement_component.movement_complete.connect(on_move_complete)

func on_level_loaded() -> void:
	direction = get_next_target(movement_component.current_tile) - movement_component.current_tile
	path.append(get_next_target(movement_component.current_tile + direction))

func get_next_target(from: Vector2i) -> Vector2i:
	var neighbors: Array[Vector2i] = Globals.tile_manager.get_traversible_neighbors(from)

	var prev_tile_index: int = neighbors.find(movement_component.current_tile)
	if prev_tile_index >= 0:
		neighbors.remove_at(prev_tile_index)

	return get_chase_target(neighbors)

func on_move_complete() -> void:
	var target: Vector2i = get_next_target(path.front())
	path.append(target)
	direction = path.pop_front() - movement_component.current_tile

func get_frightened_target(neighbors: Array[Vector2i]) -> Vector2i:
	return neighbors.get(randi_range(0, neighbors.size() - 1))

func get_scatter_target(neighbors: Array[Vector2i]) -> Vector2i:
	return get_target_for_goal(scatter_target, neighbors)

func get_chase_target(neighbors: Array[Vector2i]) -> Vector2i:
	var end_goal: Vector2i = Globals.pacman.get_current_tile()
	return get_target_for_goal(end_goal, neighbors)

func get_target_for_goal(end_goal: Vector2i, neighbors: Array[Vector2i]) -> Vector2i:
	var target: Vector2i = neighbors.front()
	var shortest_distance: float = target.distance_to(end_goal)

	for neighbor: Vector2i in neighbors.slice(1):
		var distance: float = neighbor.distance_to(end_goal)
		if distance < shortest_distance:
			target = neighbor
			shortest_distance = distance

	return target
