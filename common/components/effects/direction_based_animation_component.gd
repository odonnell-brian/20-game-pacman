class_name DirectionBasedAnimationComponent
extends Node2D

@export_category("Dependencies")
@export var animated_sprite: AnimatedSprite2D

var current_animation: String

func play_animation_for_direction(animation: String, direction: Vector2i) -> void:
	var new_animation_name: String = animation + name_for_direction(direction)

	if current_animation != new_animation_name:
		current_animation = new_animation_name
		animated_sprite.play(current_animation)

func name_for_direction(direction: Vector2i) -> String:
	match(direction):
		Vector2i.UP:
			return "_up"
		Vector2i.DOWN:
			return "_down"
		Vector2i.LEFT:
			return "_left"
		Vector2i.RIGHT:
			return "_right"

	return ""
