extends GhostMoveState

const TIME_TO_EXIT: int = 2
const LEFT_EXIT_TILE: Vector2i = Vector2i(13, 13)
const RIGHT_EXIT_TILE: Vector2i = Vector2i(14, 13)
const TILE_MOVE_DURATION: float = 0.5

@export_category("Dependencies")
@export var sprite_to_offset: AnimatedSprite2D

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.EXIT

# 13,13 14,13
func enter(previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	var closest_exit_tile: Vector2i = get_closest_exit_tile()
	move_to_exit(closest_exit_tile)

func exit() -> void:
	pass

func move_to_exit(closest_exit_tile: Vector2i) -> void:
	var position_diff: Vector2i = closest_exit_tile - movement_component.current_tile

	var tween: Tween = create_tween()
	if position_diff.x != 0:
		var final_x: float = parent.global_position.x + Globals.tile_manager.TILE_SIZE.x * position_diff.x
		tween.tween_property(parent, "global_position:x", final_x, TILE_MOVE_DURATION * abs(position_diff.x)).from_current()

	if position_diff.y != 0:
		var final_y: float = parent.global_position.y + Globals.tile_manager.TILE_SIZE.y * position_diff.y
		tween.tween_property(parent, "global_position:y", final_y, TILE_MOVE_DURATION * abs(position_diff.y)).from_current()

	tween.tween_property(sprite_to_offset, "offset:x", 0.0, movement_component.time_to_move / 2).from_current()
	tween.tween_callback(func(): movement_component.current_tile = closest_exit_tile)
	tween.finished.connect(exit_state.emit.bind(GhostBehaviorComponent.MoveState.SCATTER))

func get_closest_exit_tile() -> Vector2i:
	var closest_exit_tile: Vector2i = LEFT_EXIT_TILE
	var distance: float = closest_exit_tile.distance_to(movement_component.current_tile)

	if RIGHT_EXIT_TILE.distance_to(movement_component.current_tile) < distance:
		closest_exit_tile = RIGHT_EXIT_TILE

	return closest_exit_tile
