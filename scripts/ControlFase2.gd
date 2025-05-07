extends Node2D

const VELOCIDADE : float = 5 # representa a velocidade de queda do objeto naturalmente
const VELOCIDADE_BOOST : float = 15 # representa a velocidade de queda do objeto ao pressionar seta para baixo
const N_VARIEDADES : int = 3 # representa o numero de variedades de cada tipo de lixo
const NIVEL : int = 1 # vai de 1 a 4
var tipos
var tiposCompleto

func _ready():
	tipos = ['org', 'vid'] # Como é fase 1, tem apenas 2 lixeiras
	tiposCompleto = tipos.duplicate() # "bucket" dos tipos de lixo, serve para criar uma aleatoriedade balanceada

func _process(delta):
	var lixo = escolheLixo(tiposCompleto) # Recebe a coordenada do lixo selecionado
	var tipoLixo = tipos[lixo[0]] # Salva o tipo do lixo selecionado

func escolheLixo(tiposCompleto):
	var lixo
	if not tipos.is_empty(): # Verifica se a lista de tipos não está vazia
		tipos.shuffle()
		lixo = tipos.pop_front() # Remove aquele tipo da lista, para evitar repetição
	else:
		tipos = tiposCompleto.duplicate() # A lista está vazia, logo o "bucket aleatorio" reseta
		tipos.shuffle()
		lixo = tipos.pop_front() # Remove aquele tipo da lista, para evitar repetição
		
	var i = randi_range(0, NIVEL-1) # Seleciona um dos tipos de lixo com base na fase
	var j = randi_range(0, N_VARIEDADES-1) # Seleciona uma das 3 variedades do lixo escolhido
	var coorSprite = [i, j]
	return coorSprite # Retorna a coordenada não normalizada do lixo no sprite sheet([0] = tipo, [1] = variedade)
