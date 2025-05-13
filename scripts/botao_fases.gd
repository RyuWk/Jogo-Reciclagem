extends Node2D
@export var nomeFase : String

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/%s.tscn" %[nomeFase])
	pass # Replace with function body.
