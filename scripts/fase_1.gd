extends Node2D

enum TRASH_TYPE {ORGANIC, GLASS, METAL, PAPER, PLASTIC}

var current_trash_type = TRASH_TYPE.ORGANIC
var trash_collected = 0
var total_trash_needed = 3

@onready var instruction_label = $Label
@onready var organic_bin = $Lixeiras/LixeiraOrganica
@onready var glass_bin = $Lixeiras/LixeiraVidro
@onready var metal_bin = $Lixeiras/LixeiraMetal
@onready var paper_bin = $Lixeiras/LixeiraPapel
@onready var plastic_bin = $Lixeiras/LixeiraPlastico
@onready var completion_popup = $CompletionPopup

func _ready():
	start_phase(current_trash_type)
	# Garante que o popup está escondido no início
	completion_popup.hide()

func start_phase(trash_type):
	trash_collected = 0
	match trash_type:
		TRASH_TYPE.ORGANIC:
			instruction_label.text = "Clique nos lixos orgânicos"
			animate_bin(organic_bin)
		TRASH_TYPE.GLASS:
			instruction_label.text = "Clique nos lixos de vidro"
			animate_bin(glass_bin)
		TRASH_TYPE.PAPER:
			instruction_label.text = "Clique nos lixos de papel"
			animate_bin(paper_bin)
		TRASH_TYPE.METAL:
			instruction_label.text = "Clique nos lixos de metal"
			animate_bin(metal_bin)
		TRASH_TYPE.PLASTIC:
			instruction_label.text = "Clique nos lixos de plástico"
			animate_bin(plastic_bin)
	show_correct_trash(trash_type)

func animate_bin(bin):
	var tween = create_tween()
	tween.set_loops(4)
	tween.tween_property(bin, "modulate:a", 0.5, 0.3)
	tween.tween_property(bin, "modulate:a", 1.0, 0.3)

func show_correct_trash(trash_type):
	for trash in get_tree().get_nodes_in_group("trash"):
		trash.hide()
	for trash in get_tree().get_nodes_in_group("trash_%s" % trash_type):
		trash.show()

func _on_trash_clicked(trash_type):
	if trash_type == current_trash_type:
		trash_collected += 1
		
		# Verifica se completou todos os plásticos (última fase)
		if current_trash_type == TRASH_TYPE.PLASTIC and trash_collected >= total_trash_needed:
			show_completion_popup()
			return  # Sai sem avançar para próxima fase
			
		# Lógica normal de avanço de fase
		if trash_collected >= total_trash_needed:
			current_trash_type = wrapi(current_trash_type + 1, 0, TRASH_TYPE.size())
			start_phase(current_trash_type)

func show_completion_popup():
	completion_popup.show_completion()
	
	# Conecta o sinal apenas uma vez
	if not completion_popup.continue_pressed.is_connected(_on_continue_pressed):
		completion_popup.continue_pressed.connect(_on_continue_pressed)

func _on_continue_pressed():
	completion_popup.hide()
	# Aqui você pode adicionar lógica para reiniciar o jogo ou voltar ao menu
