class_name PathfindingMovementDirectionComponent
extends MovementDirectionComponent

const NO_TARGET: Vector2i = Vector2i(-1, -1)

@export_category("Dependencies")
@export var movement_component: MovementComponent

var path: Array[Vector2i]
var next_target: Vector2i
var goal: Vector2i = NO_TARGET

func _ready() -> void:
	movement_component.movement_complete.connect(move_to_next_target)
	Globals.level_loaded.connect(move_to_next_target)

func move_to_next_target() -> void:
	if goal == NO_TARGET or goal != Globals.pacman.get_current_tile():
		goal = Globals.pacman.get_current_tile()
		path = Globals.tile_manager.get_movement_path(movement_component.current_tile, goal)

	if not path:
		direction = Vector2.ZERO
		return

	next_target = path.pop_front()
	direction = Globals.tile_manager.get_direction_to(movement_component.current_tile, next_target)

	if direction.length() > 1:
		printerr("Target tile more than one space away. This shouldn't happen.")
	print("Target: %s\tDirection: %s\tCurrent tile: %s" % [next_target, direction, movement_component.current_tile])
