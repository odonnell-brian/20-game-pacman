class_name PelletComponent
extends Area2D

signal pellet_consumed(score_value: int, position: Vector2)

@export_category("Settings")
@export var score_value: int = 100

func do_consume(_consumer: PelletConsumerComponent) -> void:
	emit_consume_signal()
	# TODO: FX
	get_parent().queue_free()

func emit_consume_signal() -> void:
	pellet_consumed.emit(score_value, global_position)
