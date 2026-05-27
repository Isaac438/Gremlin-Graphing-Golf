extends Node2D

var t := 0.0
var speed := 0.5
var moving := false

var expression := Expression.new()
var expression_ready := false

func _ready():
	set_expression(global.function)

func set_expression(expr_text: String):
	var err = expression.parse(expr_text, ["x"])
	expression_ready = (err == OK)

func start():
	t = 0.0
	moving = true

func _process(delta):
	if !moving or !expression_ready:
		return

	t += delta * speed

	var x = (t * 10.0) - 5.0
	var y = expression.execute([x])

	if expression.has_execute_failed():
		return

	global_position = Vector2(x * 50.0, -y * 50.0) + get_viewport_rect().size / 2.0
