class_name InputMovementDirectionComponent
extends MovementDirectionComponent

func _process(_delta: float) -> void:
	var new_direction: Vector2i = Vector2i.ZERO

	if Input.is_action_pressed("move_right"):
		new_direction = Vector2i.RIGHT
	elif Input.is_action_pressed("move_left"):
		new_direction = Vector2i.LEFT
	elif Input.is_action_pressed("move_up"):
		new_direction = Vector2i.UP
	elif Input.is_action_pressed("move_down"):
		new_direction = Vector2i.DOWN

	direction = new_direction
