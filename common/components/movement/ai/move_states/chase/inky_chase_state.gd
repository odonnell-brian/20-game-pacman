extends GhostChaseState

var debug_initial_target: Sprite2D

func _ready() -> void:
	super()
	debug_initial_target = preload("res://entities/debug/target_tile.tscn").instantiate() as Sprite2D
	debug_initial_target.global_position = Vector2(-100, -100)
	get_tree().current_scene.call_deferred("add_child", debug_initial_target)

func exit() -> void:
	super()
	debug_initial_target.global_position = Vector2(-100, -100)

func get_target() -> Vector2i:
	var initial_target: Vector2i = Globals.pacman.get_current_tile() + (4 * Globals.pacman.get_current_direction())

	var blinky: Ghost = Globals.ghosts[Ghost.GhostNames.BLINKY]
	var blinky_target_diff: Vector2i = initial_target - blinky.get_current_tile()

	var target: Vector2i = initial_target + blinky_target_diff
	render_target_debug(target, 0x00ffff)
	render_target_debug(initial_target, 0x00ffff, debug_initial_target)
	print("Initial target: %s\tblinky pos: %s\tfinal target: %s" %[initial_target, blinky.get_current_tile(), target])
	return target
