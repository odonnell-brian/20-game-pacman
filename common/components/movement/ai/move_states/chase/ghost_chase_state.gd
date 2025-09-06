class_name GhostChaseState
extends MoveToTargetState

var target_sprite: Sprite2D

func _ready() -> void:
	var target_scene: PackedScene = preload("res://entities/debug/target_tile.tscn")
	target_sprite = target_scene.instantiate() as Sprite2D
	get_tree().current_scene.call_deferred("add_child", target_sprite)
	target_sprite.global_position = Vector2(-100, -100)

func exit() -> void:
	super()
	target_sprite.global_position = Vector2(-100, -100)

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.CHASE

func get_completion_timeout() -> float:
	return 20.0

func render_target_debug(target: Vector2i, color_hex: int, sprite: Sprite2D = target_sprite) -> void:
	sprite.global_position =TileManager.get_tile_center_point(target)
	sprite.modulate = Color.hex(color_hex)
	sprite.modulate.a = 1.0
	sprite.name = "%sTarget" % movement_component.get_parent().name
