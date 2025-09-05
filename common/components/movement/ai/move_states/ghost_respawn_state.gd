extends MoveToTargetState

const EYES_ANIMATION_PREFIX: String = "eyes"

@export_category("Dependencies")
@export var sprite_to_offset: AnimatedSprite2D

@export_category("Settings")
@export var spawn_tile: Vector2i = Vector2i(16, 16)

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.RESPAWN

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	frightened = false
	movement_component.speed_multiplier = 5.0
	movement_component.ignore_doors = true

	super(_previous_state)

func exit() -> void:
	movement_component.speed_multiplier = 1.0
	movement_component.ignore_doors = false
	super()

func get_ignore_doors() -> bool:
	return true

func get_target() -> Vector2i:
	return spawn_tile

func on_power_pellet() -> void:
	# Deliberately left blank. We want this state to take priority over everything else
	pass

func on_power_pellet_timeout() -> void:
	# Deliberately left blank. We want this state to take priority over everything else
	pass

func get_animation_prefix() -> String:
	return EYES_ANIMATION_PREFIX

func get_timeout_state() -> GhostBehaviorComponent.MoveState:
	return GhostBehaviorComponent.MoveState.SPAWN

func should_exit() -> bool:
	return movement_component.current_tile == spawn_tile
