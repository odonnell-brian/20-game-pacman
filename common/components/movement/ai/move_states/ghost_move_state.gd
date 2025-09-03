class_name GhostMoveState
extends Node2D

@warning_ignore("unused_signal")
signal exit_state(next_state: GhostBehaviorComponent.MoveState)

var parent: Node2D
var movement_component: MovementComponent
var direction: Vector2i

@warning_ignore("shadowed_variable")
func initialize(movement_component: MovementComponent) -> void:
	self.movement_component = movement_component

func get_associated_state() -> GhostBehaviorComponent.MoveState:
	# To be overridden
	return GhostBehaviorComponent.MoveState.NONE

func enter(_previous_state: GhostBehaviorComponent.MoveState = GhostBehaviorComponent.MoveState.NONE) -> void:
	pass

func exit() -> void:
	pass

func get_target_for_goal(end_goal: Vector2i, neighbors: Array[Vector2i]) -> Vector2i:
	var target: Vector2i = neighbors.front()
	var shortest_distance: float = target.distance_to(end_goal)

	for neighbor: Vector2i in neighbors.slice(1):
		var distance: float = neighbor.distance_to(end_goal)
		if distance < shortest_distance:
			target = neighbor
			shortest_distance = distance

	return target
