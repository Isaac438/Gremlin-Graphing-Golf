extends Node2D

var scored = false
@onready var area: Area2D = $Area2D

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Ball"):
		print("Great Shot!")
	else:
		print("Well it wasn't a ball but whatever...")
