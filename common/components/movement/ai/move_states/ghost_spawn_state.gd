extends GhostMoveState

const SPRITE_OFFSET: float = -4.0

@export_category("Dependencies")
@export var sprite_to_offset: AnimatedSprite2D

@export_category("Settings")
@export var time_to_exit: float = 1.0

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.SPAWN

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	active = true
	get_tree().create_timer(time_to_exit).timeout.connect(exit)

	sprite_to_offset.offset.x = SPRITE_OFFSET
	play_animation(MOVE_ANIMATION_PREFIX, Vector2i.LEFT)

func exit() -> void:
	active = false
	exit_state.emit(GhostBehaviorComponent.MoveState.EXIT)
