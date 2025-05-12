extends Node

@export var nomeFase : String
func _ready():
	var button = Button.new()
	button.text = "                              "
	button.pressed.connect(_button_pressed)
	add_child(button)

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/%s.tscn" %[nomeFase])
	pass
