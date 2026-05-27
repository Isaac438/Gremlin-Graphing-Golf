extends Node2D

var scored = false
@onready var area: Area2D = $Area2D

func _ready():
	area.area_entered.connect(_on_area_entered)

func _on_area_entered(body):
	if body.is_in_group("Ball"):
		global.output = "Great Shot!"
		print("Great Shot!")
		global.hole_hit = true
	elif body.is_in_group("Land"):
		pass
	else:
		global.output = "Well it wasn't a ball but whatever..."
		print("Well it wasn't a ball but whatever...")
