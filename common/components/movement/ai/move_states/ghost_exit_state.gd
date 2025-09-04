extends GhostMoveState

const TIME_TO_EXIT: int = 2
const EXIT_TILE: Vector2i = Vector2i(14, 13)
const TILE_MOVE_DURATION: float = 0.5

@export_category("Dependencies")
@export var sprite_to_offset: AnimatedSprite2D

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.EXIT

func enter(previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	move_to_exit(EXIT_TILE)

func exit() -> void:
	pass

func move_to_exit(closest_exit_tile: Vector2i) -> void:
	var position_diff: Vector2i = closest_exit_tile - movement_component.current_tile

	var tween: Tween = create_tween()
	if position_diff.x != 0:
		var final_x: float = parent.global_position.x + Globals.tile_manager.TILE_SIZE.x * position_diff.x
		tween_position(tween, "global_position:x", final_x, position_diff.x, Vector2i.RIGHT)

	if position_diff.y != 0:
		var final_y: float = parent.global_position.y + Globals.tile_manager.TILE_SIZE.y * position_diff.y
		tween_position(tween, "global_position:y", final_y, position_diff.y, Vector2i.DOWN)

	tween.tween_property(sprite_to_offset, "offset:x", 0.0, movement_component.time_to_move / 2).from_current()
	tween.tween_callback(func(): movement_component.current_tile = closest_exit_tile)
	tween.finished.connect(exit_state.emit.bind(GhostBehaviorComponent.MoveState.SCATTER))

func tween_position(tween: Tween, pos_property: String, final_position: float, pos_diff: int, direction_multiplier: Vector2i) -> void:
	var pos_direction: int = pos_diff / abs(pos_diff)
	var move_direction: Vector2i = pos_direction * direction_multiplier
	tween.tween_callback(play_animation.bind(MOVE_ANIMATION_PREFIX, move_direction))
	tween.tween_property(parent, pos_property, final_position, TILE_MOVE_DURATION * abs(pos_diff)).from_current()
