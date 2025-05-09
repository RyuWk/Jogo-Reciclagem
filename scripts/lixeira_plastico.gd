extends Area2D

@export var tipo_lixeira: String = "pla"  # Pode ser: "org", "vid", etc.

func _ready():
	body_entered.connect(_on_body_entered) # Conecta o sinal de área entrando

func _on_body_entered(body):
	SignalBus.lixo_entrou.emit(tipo_lixeira)
	body.queue_free() # Deleta lixo do nivel
