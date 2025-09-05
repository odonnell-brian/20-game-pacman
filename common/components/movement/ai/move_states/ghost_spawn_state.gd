extends GhostMoveState

const TIME_UNTIL_EXIT: int = 1
const SPRITE_OFFSET: float = -4.0

@export_category("Dependencies")
@export var sprite_to_offset: AnimatedSprite2D

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.SPAWN

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	active = true
	get_tree().create_timer(TIME_UNTIL_EXIT).timeout.connect(exit)

	sprite_to_offset.offset.x = SPRITE_OFFSET
	play_animation(MOVE_ANIMATION_PREFIX, Vector2i.LEFT)

func exit() -> void:
	active = false
	exit_state.emit(GhostBehaviorComponent.MoveState.EXIT)
