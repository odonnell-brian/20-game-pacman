extends Node

@warning_ignore("unused_signal")
signal player_ready()

@warning_ignore("unused_signal")
signal level_loaded()

@warning_ignore("unused_signal")
signal power_pellet_consumed()

@warning_ignore("unused_signal")
signal power_pellet_timeout()

var tile_manager: TileManager
var pacman: Pacman

var ghosts: Dictionary[Ghost.GhostNames, Ghost] = {}
