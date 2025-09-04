extends MoveToTargetState

@export_category("Settings")
@export var scatter_target: Vector2i

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.SCATTER

func get_target() -> Vector2i:
	return scatter_target

func get_completion_timeout() -> float:
	return 7.0

func get_timeout_state() -> GhostBehaviorComponent.MoveState:
	if frightened:
		return GhostBehaviorComponent.MoveState.FRIGHTENED

	return GhostBehaviorComponent.MoveState.CHASE
