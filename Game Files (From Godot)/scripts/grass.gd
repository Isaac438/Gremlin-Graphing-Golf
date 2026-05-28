extends Node2D
@onready var viewport_x = get_viewport_rect().size.x
@onready var viewport_y = get_viewport_rect().size.y
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(viewport_x / 2, viewport_y / 1.17)
