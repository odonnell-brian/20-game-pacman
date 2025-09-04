class_name Pacman
extends GridBasedEntity

func _init() -> void:
	Globals.pacman = self

func _ready() -> void:
	super()
	Globals.player_ready.emit()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Globals.power_pellet_consumed.emit()
	elif Input.is_action_just_pressed("ui_up"):
		Globals.power_pellet_timeout.emit()

func get_current_tile() -> Vector2i:
	return movement_component.current_tile

func get_current_direction() -> Vector2i:
	return movement_component.current_direction
