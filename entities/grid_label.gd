@tool
extends GridBasedEntity

@export var text: String

func _ready() -> void:
	$Label.text = text

func _process(delta: float) -> void:
	super(delta)
	%Label.text = text
