extends GhostChaseState

func get_target() -> Vector2i:
	var target: Vector2i = Globals.pacman.get_current_tile() + (2 * Globals.pacman.get_current_direction())
	render_target_debug(target, 0xffb7ff)
	return target
