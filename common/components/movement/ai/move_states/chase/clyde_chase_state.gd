extends GhostChaseState

@export_category("Settings")
@export var distance_radius: float = 8.0
@export var scatter_target: Vector2i = Vector2i()

func get_target() -> Vector2i:
	var distance_to_pacman: float = Globals.pacman.get_current_tile().distance_to(movement_component.current_tile)

	print(distance_to_pacman)
	var target: Vector2i = Globals.pacman.get_current_tile()
	if distance_to_pacman <= distance_radius:
		target = scatter_target

	render_target_debug(target, 0xffb751)
	return target
