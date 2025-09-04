class_name GhostMoveState
extends Node2D

const MOVE_ANIMATION_PREFIX: String = "move"
const FRIGHTENED_ANIMATION_NAME: String = "frightened"

@warning_ignore("unused_signal")
signal exit_state(next_state: GhostBehaviorComponent.MoveState)

var parent: Node2D
var movement_component: MovementComponent
var animation_component: DirectionBasedAnimationComponent
var direction: Vector2i
var frightened: bool = false
var last_requested_animation: AnimationInfo = AnimationInfo.new()

func _ready() -> void:
	Globals.power_pellet_consumed.connect(on_power_pellet)
	Globals.power_pellet_timeout.connect(on_power_pellet_timeout)

@warning_ignore("shadowed_variable")
func initialize(parent: Node2D, movement_component: MovementComponent, animation_component: DirectionBasedAnimationComponent) -> void:
	self.parent = parent
	self.movement_component = movement_component
	self.animation_component = animation_component

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	# To be overridden
	return GhostBehaviorComponent.MoveState.NONE

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	pass

func exit() -> void:
	pass

func on_power_pellet() -> void:
	frightened = true
	animation_component.play_animation_for_direction(FRIGHTENED_ANIMATION_NAME, Vector2i.ZERO)

func on_power_pellet_timeout() -> void:
	frightened = false
	animation_component.play_animation_for_direction(last_requested_animation.anim_name, last_requested_animation.move_dir)

func play_animation(anim_name: String, move_dir: Vector2i) -> void:
	last_requested_animation.anim_name = anim_name
	last_requested_animation.move_dir = move_dir
	if frightened:
		animation_component.play_animation_for_direction(FRIGHTENED_ANIMATION_NAME, Vector2i.ZERO)
	else:
		animation_component.play_animation_for_direction(anim_name, move_dir)

class AnimationInfo:
	var anim_name: String
	var move_dir: Vector2i
