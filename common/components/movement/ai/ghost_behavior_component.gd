class_name GhostBehaviorComponent
extends MovementDirectionComponent

enum MoveState {NONE, SPAWN, EXIT, CHASE, SCATTER, FRIGHTENED}

@export_category("Dependencies")
@export var movement_component: MovementComponent

@export_category("Settings")
@export var scatter_target: Vector2i = Vector2i.ZERO

var current_state: MoveState = MoveState.SPAWN
var path: Array[Vector2i] = []
var states: Dictionary[MoveState, GhostMoveState] = {}

func _ready() -> void:
	for child in get_children():
		if child is GhostMoveState:
			var move_state: GhostMoveState = child as GhostMoveState
			move_state.parent = get_parent()
			move_state.movement_component = movement_component
			states[move_state.get_associated_state()] = move_state
			move_state.exit_state.connect(on_state_exit)
	Globals.level_loaded.connect(on_level_loaded)

func _process(_delta: float) -> void:
	if states[current_state]:
		direction = states[current_state].direction
	else:
		direction = Vector2i.ZERO

func on_level_loaded() -> void:
	current_state = MoveState.SPAWN
	states[current_state].enter()

func on_state_exit(next_state: MoveState) -> void:
	states[next_state].enter(current_state)
	current_state = next_state
	print("%s moving to state: %s" % [get_parent().name, next_state])
