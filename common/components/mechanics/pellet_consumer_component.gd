class_name PelletConsumerComponent
extends Area2D

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(pellet: PelletComponent) -> void:
	if not pellet:
		return

	pellet.do_consume(self)
