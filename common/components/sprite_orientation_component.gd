class_name SpriteOrientationComponent
extends Node2D

@export_category("Dependencies")
@export var sprite: AnimatedSprite2D
@export var movement_component: MovementComponent

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var direction = movement_component.current_direction

	if direction == Vector2i.ZERO:
		return

	if direction == Vector2i.LEFT:
		sprite.rotation = 0.0
		sprite.flip_h = true
		return

	# Rotate the sprite for up/down movement
	sprite.flip_h = false
	var pi_multiplier: float = 0.0
	match direction:
		Vector2i.DOWN:
			pi_multiplier = 1 / 2.0
		Vector2i.UP:
			pi_multiplier = 3 / 2.0

	sprite.rotation = (PI * pi_multiplier)
