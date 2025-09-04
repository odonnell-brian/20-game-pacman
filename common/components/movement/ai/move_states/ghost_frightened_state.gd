extends MoveToTargetState

var next_state: GhostBehaviorComponent.MoveState

func enter(previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	super(previous_state)
	next_state = previous_state

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.FRIGHTENED

func get_target() -> Vector2i:
	return Vector2i.ZERO

func get_timeout_state() -> GhostBehaviorComponent.MoveState:
	return next_state

func get_target_for_goal(end_goal: Vector2i, neighbors: Array[Vector2i]) -> Vector2i:
	return neighbors.get(randi_range(0, neighbors.size() - 1))

func on_power_pellet_timeout() -> void:
	super()
	complete = true

func should_exit() -> bool:
	return false
