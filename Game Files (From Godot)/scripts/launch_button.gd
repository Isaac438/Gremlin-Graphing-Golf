extends Button

@onready var ball = get_node("/root/World/Graph and Ball/Ball")

func _pressed():
	ball.set_expression(global.function)
	ball.start()
	print("67")
