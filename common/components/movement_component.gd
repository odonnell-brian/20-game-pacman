class_name MovementComponent
extends Node2D

signal movement_started()
signal movement_complete()

@export_category("Dependencies")
@export var direction_component: MovementDirectionComponent

@export_category("Settings")
@export var time_to_move: float = 0.25

var starting_tile: Vector2i = Vector2i(1, 1)
var current_tile: Vector2i
var move_in_progress = false
var current_direction: Vector2i
var next_direction: Vector2i

func _process(_delta: float) -> void:
	var direction: Vector2i = direction_component.direction

	var direction_changed: bool = try_move(direction)
	if direction_changed:
		next_direction = Vector2i.ZERO
		return

	if direction != Vector2i.ZERO and direction != current_direction:
		next_direction = direction

	var moved_next_direction: bool = try_move(next_direction)
	next_direction = next_direction if not moved_next_direction else Vector2i.ZERO

	if not moved_next_direction:
		var move_continued = try_move(current_direction)

func try_move(direction: Vector2i) -> bool:
	var target_tile = current_tile + direction

	if move_in_progress or direction == Vector2i.ZERO or not Globals.tile_manager.is_tile_movable(target_tile):
		return false

	current_direction = direction
	do_move(target_tile)
	return true

func do_move(target_tile: Vector2i) -> void:
	move_in_progress = true
	var move_tween: Tween = create_tween()
	move_tween.tween_property(get_parent(), "global_position", TileManager.get_tile_center_point(target_tile), time_to_move)
	move_tween.tween_callback(on_move_tween_complete.bind(target_tile))
	movement_started.emit()

func on_move_tween_complete(target_tile: Vector2i) -> void:
	current_tile = target_tile
	move_in_progress = false
	movement_complete.emit()

func try_target_direction(direction: Vector2i) -> bool:
	var target_tile = current_tile + direction
	return direction != Vector2i.ZERO and Globals.tile_manager.is_tile_movable(target_tile)
