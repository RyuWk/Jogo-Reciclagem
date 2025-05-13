extends Node2D
enum TRASH_TYPE {ORGANIC, GLASS, METAL, PAPER, PLASTIC}
@export var trash_type = TRASH_TYPE.PAPER

func _ready():
	add_to_group("trash")
	add_to_group("trash_%s" % trash_type)

func _on_button_pressed() -> void:
	get_parent().get_parent().get_parent()._on_trash_clicked(trash_type)
	get_parent().queue_free()
	queue_free()
	pass
