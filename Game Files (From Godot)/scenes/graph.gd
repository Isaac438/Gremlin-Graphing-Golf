extends Node2D

@export var expression_text := "-2.5"
@export var graph_scale := 50.0
@export var point_count := 400

var expression := Expression.new()

func _ready():
	expression.parse(expression_text, ["x"])
	queue_redraw()

func _draw():
	var last_point = null
	for i in range(point_count):
		var x = (i - point_count / 2.0) / 20.0

		var y = expression.execute([x])

		if expression.has_execute_failed():
			return

		var screen_pos = Vector2(
			x * graph_scale,
			-y * graph_scale
		)

		screen_pos += get_viewport_rect().size / 2.0

		if last_point != null:
			draw_line(last_point, screen_pos, Color.WHITE, 2.0)

		last_point = screen_pos
