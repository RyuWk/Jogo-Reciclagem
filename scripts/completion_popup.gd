extends CanvasLayer

signal continue_pressed

@onready var panel = $CompletionPanel
@onready var darken_bg = $DarkenBackground

func _ready():
	panel.modulate.a = 0
	darken_bg.color.a = 0
	hide()

func show_completion():
	$CompletionPanel/Label.text = "Fase 1 Completa!"
	show()
	
	var tween = create_tween()
	tween.tween_property(darken_bg, "color:a", 0.7, 0.3)
	tween.parallel().tween_property(panel, "modulate:a", 1, 0.3)

func _on_continue_button_pressed():
	var tween = create_tween()
	tween.tween_property(darken_bg, "color:a", 0, 0.3)
	tween.parallel().tween_property(panel, "modulate:a", 0, 0.3)
	tween.tween_callback(hide)
	continue_pressed.emit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fases.tscn")
	pass # Replace with function body.
