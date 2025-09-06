class_name PowerPelletComponent
extends PelletComponent

func emit_consume_signal() -> void:
	Globals.power_pellet_consumed.emit()
