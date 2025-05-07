extends Node2D

func _ready():
	Sprite2D.region_rect.position.x = Sprite2D.region_rect.size.x
	Sprite2D.region_rect.position.y = Sprite2D.region_rect.size.y
