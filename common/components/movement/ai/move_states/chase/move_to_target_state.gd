class_name MoveToTargetState
extends GhostMoveState

var path: Array[Vector2i] = []
var complete = false

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	complete = false
	movement_component.movement_started.connect(on_move_started)
	movement_component.movement_complete.connect(on_move_complete)

	direction = get_next_target(movement_component.current_tile) - movement_component.current_tile
	path = [get_next_target(movement_component.current_tile + direction)]

	if get_completion_timeout() > 0:
		get_tree().create_timer(get_completion_timeout()).timeout.connect(on_completion_timeout)

func exit() -> void:
	movement_component.movement_complete.disconnect(on_move_complete)
	movement_component.movement_started.disconnect(on_move_started)

	exit_state.emit(get_timeout_state())

func on_move_started() -> void:
	direction = Vector2i.ZERO

func on_move_complete() -> void:
	if complete:
		exit()
		return

	var target: Vector2i = get_next_target(path.front())
	path.append(target)
	direction = path.pop_front() - movement_component.current_tile

func on_completion_timeout() -> void:
	complete = true

func get_next_target(from: Vector2i) -> Vector2i:
	var neighbors: Array[Vector2i] = Globals.tile_manager.get_traversible_neighbors(from)

	var prev_tile_index: int = neighbors.find(movement_component.current_tile)
	if prev_tile_index >= 0:
		neighbors.remove_at(prev_tile_index)

	return get_target_for_goal(get_target(), neighbors)

func get_target() -> Vector2i:
	# To be overridden
	return Vector2i()

func get_completion_timeout() -> float:
	return -1.0

func get_timeout_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.SCATTER
