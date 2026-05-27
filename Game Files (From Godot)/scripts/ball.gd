extends Node2D

var t := 0.0
var speed := 1.0
var moving := false
@onready var area: Area2D = $Area2D
var expression := Expression.new()
var expression_ready := false
var timeout = 2.0 / speed

func _ready():
	set_expression(global.expression_text)
	area.area_entered.connect(_on_area_entered)
	area.body_entered.connect(_on_body_entered)
	
func set_expression(expr_text: String):
	var err = expression.parse(expr_text, ["x"])
	expression_ready = (err == OK)

func start():
	set_expression(global.expression_text)
	t = 0.0
	moving = true

func _on_body_entered(body):
	if body.is_in_group("Hole"):
		pass
	else:
		moving = false
		global_position = Vector2.ZERO
		global.output = "You hit a hazard!"
		print("bad")
func _on_area_entered(area):
	if area.is_in_group("Hole"):
		pass
	else:
		moving = false
		global_position = Vector2.ZERO
		print("bad")

func _process(delta):
	if !moving or !expression_ready:
		return
	t += delta * speed

	var x = (t * 10.0) - 10.0
	var y = expression.execute([x])

	if expression.has_execute_failed():
		return

	global_position = Vector2(x * 50.0, -y * 50.0) + get_viewport_rect().size / 2.0
	if t >= timeout and global.hole_hit == false:
		global.output = "You Missed!"
		moving = false
		global_position = Vector2.ZERO
	elif t >= timeout and global.hole_hit == true:
		global.hole_hit = false
		moving = false
		global.output = "Great Shot!"
