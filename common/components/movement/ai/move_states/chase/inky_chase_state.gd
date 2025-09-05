extends GhostChaseState

func get_target() -> Vector2i:
	var target: Vector2i = Globals.pacman.get_current_tile()
	render_target_debug(target, 0x00ffff)
	return target
