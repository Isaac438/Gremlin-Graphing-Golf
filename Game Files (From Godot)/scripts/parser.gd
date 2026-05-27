extends Node

var expression := Expression.new()
var expression_text := "x"
var expression_valid := false

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


func _process(delta: float) -> void:
	if global.function:
		global.expression_text = parse_input(global.function)
