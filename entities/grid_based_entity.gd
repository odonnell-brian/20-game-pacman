class_name GridBasedEntity
extends Node2D

@export_category("Settings")
@export var starting_tile: Vector2i

@export_category("Optional Dependencies")
@export var movement_component: MovementComponent

func _ready() -> void:
	if movement_component:
		movement_component.current_tile = starting_tile

func get_current_tile() -> Vector2i:
	return movement_component.current_tile

func get_current_direction() -> Vector2i:
	return movement_component.current_direction
