class_name BlinkyChaseState
extends MoveToTargetState

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.CHASE

func get_target() -> Vector2i:
	return Globals.pacman.get_current_tile()

func get_completion_timeout() -> float:
	return 20.0
