extends LineEdit

func _process(_delta: float) -> void:
	if global.function != text:
		global.function = text
