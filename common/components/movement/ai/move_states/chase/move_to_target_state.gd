class_name MoveToTargetState
extends GhostMoveState

var path: Array[Vector2i] = []
var complete = false
var completion_timer: SceneTreeTimer

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	complete = false
	active = true
	movement_component.movement_started.connect(on_move_started)
	movement_component.movement_complete.connect(on_move_complete)

	direction = Globals.tile_manager.get_direction_to(movement_component.current_tile, get_next_target(movement_component.current_tile))
	path = [get_next_target(Globals.tile_manager.get_neighbor_in_direction(movement_component.current_tile, direction))]

	play_animation(get_animation_prefix(), direction)
	if get_completion_timeout() > 0:
		completion_timer = get_tree().create_timer(get_completion_timeout())
		completion_timer.timeout.connect(on_completion_timeout)

func exit() -> void:
	movement_component.movement_complete.disconnect(on_move_complete)
	movement_component.movement_started.disconnect(on_move_started)

	if completion_timer:
		completion_timer.timeout.disconnect(on_completion_timeout)

	var next_state: GhostBehaviorComponent.MoveState = get_timeout_state()
	active = false
	exit_state.emit(next_state)

func on_move_started() -> void:
	direction = Vector2i.ZERO

func on_move_complete() -> void:
	if complete or should_exit():
		exit()
		return

	var target: Vector2i = get_next_target(path.front())
	path.append(target)
	direction = Globals.tile_manager.get_direction_to(movement_component.current_tile, path.pop_front())
	play_animation(get_animation_prefix(), direction)

func on_completion_timeout() -> void:
	complete = true

func get_next_target(from: Vector2i) -> Vector2i:
	var neighbors: Array[Vector2i] = Globals.tile_manager.get_traversible_neighbors(from, get_ignore_doors())

	var prev_tile_index: int = neighbors.find(movement_component.current_tile)
	if prev_tile_index >= 0:
		neighbors.remove_at(prev_tile_index)

	if neighbors.size() == 0:
		return movement_component.current_tile

	return get_target_for_goal(get_target(), neighbors)

func get_target_for_goal(end_goal: Vector2i, neighbors: Array[Vector2i]) -> Vector2i:
	var target: Vector2i = neighbors.front()
	var shortest_distance: float = target.distance_to(end_goal)

	for neighbor: Vector2i in neighbors.slice(1):
		var distance: float = neighbor.distance_to(end_goal)
		if distance < shortest_distance:
			target = neighbor
			shortest_distance = distance

	return target

func get_ignore_doors() -> bool:
	return false

func get_target() -> Vector2i:
	# To be overridden
	return Vector2i()

func get_completion_timeout() -> float:
	return -1.0

func get_timeout_state() -> GhostBehaviorComponent.MoveState:
	if frightened:
		return GhostBehaviorComponent.MoveState.FRIGHTENED

	return GhostBehaviorComponent.MoveState.SCATTER

func should_exit() -> bool:
	return frightened

func get_animation_prefix() -> String:
	return MOVE_ANIMATION_PREFIX
