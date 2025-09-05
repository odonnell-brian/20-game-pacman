extends MoveToTargetState

var next_state: GhostBehaviorComponent.MoveState
var to_respawn: bool = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right"):
		to_respawn = true
		exit_frightened.emit()

func enter(previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	super(previous_state)
	next_state = previous_state
	to_respawn = false

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.FRIGHTENED

func get_target() -> Vector2i:
	return Vector2i.ZERO

func get_timeout_state() -> GhostBehaviorComponent.MoveState:
	if to_respawn:
		return GhostBehaviorComponent.MoveState.RESPAWN

	return next_state

func get_target_for_goal(_end_goal: Vector2i, neighbors: Array[Vector2i]) -> Vector2i:
	return neighbors.get(randi_range(0, neighbors.size() - 1))

func on_power_pellet_timeout() -> void:
	super()
	complete = true

func should_exit() -> bool:
	return to_respawn
