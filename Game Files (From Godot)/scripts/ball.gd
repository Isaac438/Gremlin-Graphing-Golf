extends Node2D

var t := 0.0
var speed := 0.5
var moving := false
@onready var area: Area2D = $Area2D
var expression := Expression.new()
var expression_ready := false
var expression_text = global.function

func parse_input(text):
	text = text.replace(" ", "")

	while text.contains("^"):
		var index = text.find("^")
		var base = text.substr(index - 1, 1)
		var exponent = text.substr(index + 1, 1).to_int()
		var expanded = base

		for i in range(exponent - 1):
			expanded += "*" + base

		text = text.substr(0, index - 1) + expanded + text.substr(index + 2)
	
	var regex = RegEx.new()
	regex.compile("(\\d+)(x)")
	text = regex.sub(text, "$1*$2", true)
	
	return text

func _ready():
	set_expression(global.function)
	area.area_entered.connect(_on_area_entered)
	area.body_entered.connect(_on_area_entered)
	
func set_expression(expr_text: String):
	var err = expression.parse(expr_text, ["x"])
	expression_ready = (err == OK)

func start():
	t = 0.0
	moving = true

func _on_area_entered(area):
	if area.is_in_group("Hole"):
		pass
	else:
		moving = false
		global_position = Vector2(0,0)
		print("bad")

func _process(delta):
	if !moving or !expression_ready:
		return

	t += delta * speed

	var x = (t * 10.0) - 5.0
	var y = expression.execute([x])

	if expression.has_execute_failed():
		return

	global_position = Vector2(x * 50.0, -y * 50.0) + get_viewport_rect().size / 2.0
