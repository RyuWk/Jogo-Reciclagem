extends CharacterBody2D

@export var velocidade_queda_base : float = 200  # velocidade normal (pixels/seg)
@export var velocidade_multiplicador_boost : float = 5  # 5x mais rápido ao apertar S ou seta para baixo
@export var distancia_snap: int = 128  # distancia de snap (lock)
var velocidade_queda_atual: float # Velocidade atual atualiza ao apertar (ou não) S ou seta para baixo
var posicao_alvo := Vector2(576, -16)  # Posicao global do lixo
var esta_caindo_rapido := false

func _ready():
	global_position = posicao_alvo
	velocidade_queda_atual = velocidade_queda_base

func _physics_process(delta):
	# Atualiza velocidade
	esta_caindo_rapido = Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S)
	velocidade_queda_atual = velocidade_queda_base * (velocidade_multiplicador_boost if esta_caindo_rapido else 1.0)
	
	# Movimento vertical de queda
	posicao_alvo.y += velocidade_queda_atual * delta
	global_position = global_position.lerp(posicao_alvo, 0.2)
	
	# Suaviza o movimento horizontal
	position.x = lerp(position.x, posicao_alvo.x, 0.5)  # mais rápido no eixo X

func _input(event): # Movimento horizontal com snapping para cima dos lixos (distancia fixa)
	if event.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		posicao_alvo += Vector2.LEFT * distancia_snap
	elif event.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		posicao_alvo += Vector2.RIGHT * distancia_snap
	# REQUISITO: Verifica se não saiu da tela de jogo
