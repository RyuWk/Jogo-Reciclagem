extends Node

@export var pontuacao_label : Label # Representa o marcador que dita a pontuacao
const N_VARIEDADES : int = 3 # representa o numero de variedades de cada tipo de lixo
const NIVEL : int = 1 # vai de 1 a 4
var tipos #  Array com os tipos de lixo do nivel (nivel 1 = organicos e vidro"
var tiposCompleto # O mesmo array do acima, mas ele servirá para usar o método pseudo-aleatório do "bucket"
var coorSprite # Array que representa a posição no spreadsheet do sprite. [0] = tipo, [1] = variedade
var tipo_lixo : String # Salva o tipo de lixo que está caindo ('org', 'vid', etc)
var posicao_instanciamento := Vector2(-72, -32) # Local de spawn, deve ser editado dependendo do nivel
var lixo_instanciado = preload("res://scenes/lixo.tscn") # Salva a cena do lixo a ser instanciado
var pontuacao : int = 0 # Pontuacao do nivel

func _ready():
	atualiza_pontuacao() # Instancia pontuacao = 0
	tipos = ['org', 'vid'] # Como é fase 1, tem apenas 2 lixeiras
	tiposCompleto = tipos.duplicate() # "bucket" dos tipos de lixo, serve para criar uma aleatoriedade balanceada
	
	coorSprite = escolheLixo()
	tipo_lixo = tiposCompleto[coorSprite[0]] # Salva o tipo do lixo selecionado
	
	spawna_lixo()
	
	SignalBus.novo_lixo.emit(coorSprite) # Envia as coor do sprite para a cena lixo
	
	SignalBus.lixo_entrou.connect(_on_lixo_entrou) # Recebe o tipo da lixeira onde o lixo entrou

func _on_lixo_entrou(tipo_lixeira): # Ativa se a lixeira detecta que um lixo entrou
	if (tipo_lixeira == tipo_lixo):
		print("LIXO CORRETO")
		add_pontuacao(10)
		atualiza_pontuacao()
	else:
		print("LIXO INCORRETO")
		add_pontuacao(-5)
		atualiza_pontuacao()
	
	# Spawna um novo lixo
	coorSprite = escolheLixo()
	tipo_lixo = tiposCompleto[coorSprite[0]]
	spawna_lixo()
	
	SignalBus.novo_lixo.emit(coorSprite) # Envia as coor do sprite para a cena lixo
	
func spawna_lixo(): # Instancia a cena Lixo como filho do nó fase2nivel1
	var instancia = lixo_instanciado.instantiate()
	instancia.position = posicao_instanciamento
	self.add_child(instancia)

func escolheLixo(): # Utiliza uma forma pseudo-aleatória para escolher o tipo do lixo, dentro os disponíveis na fase
	var lixo
	var i
	if not tipos.is_empty(): # Verifica se a lista de tipos não está vazia
		tipos.shuffle()
		lixo = tipos.pop_front() # Remove aquele tipo da lista, para evitar repetição
	else:
		tipos = tiposCompleto.duplicate() # A lista está vazia, logo o "bucket aleatorio" reseta
		tipos.shuffle()
		lixo = tipos.pop_front() # Remove aquele tipo da lista, para evitar repetição
	
	if lixo == 'org':
		i = 0
	elif lixo == 'vid':
		i = 1
	var j : int = randi_range(0, N_VARIEDADES-1) # Seleciona uma das 3 variedades do lixo escolhido
	return [i, j]

func atualiza_pontuacao(): # Mostra a pontuacao no label do nivel
	pontuacao_label.text = "Pontuação: \n" + str(pontuacao)

func add_pontuacao(pontos: int): # Soma a pontuacao do parametro no label
	pontuacao += pontos
	atualiza_pontuacao()
